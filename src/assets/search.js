(function () {
  "use strict";

  function normalizeWhitespace(value) {
    return (value || "").replace(/\s+/g, " ").trim();
  }

  function normalizeText(value) {
    return normalizeWhitespace(value).toLowerCase();
  }

  function tokenize(value) {
    return normalizeText(value).split(/[^0-9\p{L}\p{N}]+/u).filter(Boolean);
  }

  function escapeRegex(value) {
    return value.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
  }

  function escapeHtml(value) {
    return value
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/\"/g, "&quot;");
  }

  function wholeWordRegex(token) {
    return new RegExp("(^|[^\\p{L}\\p{N}])(" + escapeRegex(token) + ")(?=[^\\p{L}\\p{N}]|$)", "giu");
  }

  function wholeWordCount(text, token) {
    var matches = text.match(wholeWordRegex(token));
    return matches ? matches.length : 0;
  }

  function substringCount(text, token) {
    if (!token) return 0;
    var count = 0;
    var start = 0;
    while (start < text.length) {
      var index = text.indexOf(token, start);
      if (index === -1) break;
      count += 1;
      start = index + token.length;
    }
    return count;
  }

  function firstWholeWordIndex(text, token) {
    var match = wholeWordRegex(token).exec(text);
    return match ? match.index + match[1].length : -1;
  }

  function blockScore(block, query, tokens) {
    var text = block.textNormalized || "";
    var score = 0;
    var matched = false;

    if (!query) return score;

    if (text === query) {
      score += 2200;
      matched = true;
    } else if (text.indexOf(query) !== -1) {
      score += 900;
      matched = true;
    }

    if (tokens.length > 0) {
      var position = -1;
      var orderedHits = 0;
      var wholeHits = 0;
      var partialHits = 0;
      var matchedTokens = 0;
      tokens.forEach(function (token) {
        var wholeMatches = wholeWordCount(text, token);
        var next = wholeMatches > 0 ? firstWholeWordIndex(text.slice(position + 1), token) : -1;
        if (wholeMatches > 0) {
          wholeHits += wholeMatches;
          matchedTokens += 1;
          matched = true;
          if (next >= position) {
            orderedHits += 1;
            position = position + 1 + next;
          }
        } else if (text.indexOf(token) !== -1) {
          partialHits += substringCount(text, token);
          matchedTokens += 1;
          matched = true;
        }
      });

      if (matchedTokens < tokens.length) return 0;
      if (orderedHits === tokens.length && tokens.length > 1) score += 700;
      score += wholeHits * 170;
      score += partialHits * 35;
    }

    if (!matched) return 0;

    if (block.kind === "heading") score -= 120;

    return score;
  }

  function titleScore(page, query, tokens) {
    var title = page.titleNormalized || "";
    var score = 0;

    if (title === query) {
      score += 3600;
    } else if (title.indexOf(query) !== -1) {
      score += 1650;
    }

    if (tokens.length > 0) {
      var titleWholeHits = 0;
      var titlePartialHits = 0;
      var matchedTokens = 0;

      tokens.forEach(function (token) {
        var titleWhole = wholeWordCount(title, token);
        titleWholeHits += titleWhole;
        if (titleWhole > 0) {
          matchedTokens += 1;
        } else if (title.indexOf(token) !== -1) {
          titlePartialHits += substringCount(title, token);
          matchedTokens += 1;
        }
      });

      if (matchedTokens < tokens.length) return 0;
      if (titleWholeHits >= tokens.length) score += 1100;
      score += titleWholeHits * 200;
      score += titlePartialHits * 45;
    }

    return score;
  }

  function renderEmpty(target, message) {
    target.innerHTML = '<div class="search-empty">' + escapeHtml(message) + "</div>";
  }

  function resultUrl(path) {
    return "../" + path.replace(/\\/g, "/");
  }

  function highlightText(text, tokens) {
    if (!text || tokens.length === 0) return escapeHtml(text || "");

    var pattern = tokens
      .filter(function (token) { return token.length > 1; })
      .map(function (token) { return escapeRegex(token); })
      .join("|");

    if (!pattern) return escapeHtml(text);

    var regex = new RegExp("(" + pattern + ")", "giu");
    return escapeHtml(text).replace(regex, '<mark class="search-highlight">$1</mark>');
  }

  function firstTokenIndex(text, tokens) {
    var normalized = normalizeText(text);
    var best = -1;

    tokens.forEach(function (token) {
      var whole = firstWholeWordIndex(normalized, token);
      if (whole !== -1 && (best === -1 || whole < best)) {
        best = whole;
        return;
      }

      var partial = normalized.indexOf(token);
      if (partial !== -1 && (best === -1 || partial < best)) {
        best = partial;
      }
    });

    return best;
  }

  function textSnippet(text, tokens, maxLength) {
    var value = normalizeWhitespace(text || "");
    if (!value) return "";

    var limit = maxLength || 220;
    if (value.length <= limit) return value;

    var matchIndex = firstTokenIndex(value, tokens);
    if (matchIndex === -1) {
      return value.slice(0, limit - 1).trimEnd() + "…";
    }

    var start = Math.max(0, matchIndex - Math.floor(limit * 0.35));
    var end = Math.min(value.length, start + limit);

    if (end - start < limit && start > 0) {
      start = Math.max(0, end - limit);
    }

    while (start > 0 && /\S/.test(value.charAt(start - 1))) {
      start -= 1;
    }
    while (end < value.length && /\S/.test(value.charAt(end))) {
      end += 1;
    }

    var snippet = value.slice(start, end).trim();
    if (start > 0) snippet = "…" + snippet;
    if (end < value.length) snippet += "…";
    return snippet;
  }

  function highlightHtmlSnippet(html, tokens) {
    if (!html) return "";

    var template = document.createElement("template");
    template.innerHTML = html;
    template.content.querySelectorAll(".page-nav, sup[role='doc-backlink'], .typst-multi-label-list, .eq-tag, .equation-tag-group, .equation-tag-holder, .page-source-heading, script, style").forEach(function (node) {
      node.remove();
    });
    template.content.querySelectorAll("[id]").forEach(function (node) {
      node.removeAttribute("id");
    });
    template.content.querySelectorAll("a").forEach(function (link) {
      var fragment = document.createDocumentFragment();
      while (link.firstChild) fragment.appendChild(link.firstChild);
      link.replaceWith(fragment);
    });

    if (tokens.length === 0) return template.innerHTML;

    var pattern = tokens
      .filter(function (token) { return token.length > 1; })
      .map(function (token) { return escapeRegex(token); })
      .join("|");
    if (!pattern) return template.innerHTML;

    var regex = new RegExp("(" + pattern + ")", "giu");
    var walker = document.createTreeWalker(template.content, NodeFilter.SHOW_TEXT);
    var nodes = [];
    while (walker.nextNode()) {
      nodes.push(walker.currentNode);
    }

    nodes.forEach(function (node) {
      regex.lastIndex = 0;
      if (!node.nodeValue || !regex.test(node.nodeValue)) return;
      regex.lastIndex = 0;
      var parent = node.parentNode;
      if (!parent) return;
      var name = parent.nodeName.toLowerCase();
      if (name === "math" || parent.closest("math")) return;

      var fragment = document.createDocumentFragment();
      var lastIndex = 0;
      node.nodeValue.replace(regex, function (match, _group, offset) {
        if (offset > lastIndex) {
          fragment.appendChild(document.createTextNode(node.nodeValue.slice(lastIndex, offset)));
        }
        var mark = document.createElement("mark");
        mark.className = "search-highlight";
        mark.textContent = match;
        fragment.appendChild(mark);
        lastIndex = offset + match.length;
        return match;
      });
      if (lastIndex < node.nodeValue.length) {
        fragment.appendChild(document.createTextNode(node.nodeValue.slice(lastIndex)));
      }
      parent.replaceChild(fragment, node);
    });

    return template.innerHTML;
  }

  function snippetHtmlForBlock(block, tokens) {
    if (!block) return "";
    if (block.kind === "math" && (block.html || "").indexOf("<math") !== -1) {
      return highlightHtmlSnippet(block.html || "", tokens);
    }
    var snippet = textSnippet(block.text || "", tokens, 220);
    if (snippet) {
      return "<p>" + highlightText(snippet, tokens) + "</p>";
    }
    if (block.kind === "heading") {
      return "<p>" + highlightText(block.text || "", tokens) + "</p>";
    }
    return highlightHtmlSnippet(block.html || "", tokens);
  }

  function buildResultUrl(page, block, query) {
    var url = resultUrl(page.path);
    var params = new URLSearchParams();
    params.set("search", query);
    url += "?" + params.toString();
    if (block && block.anchor) {
      url += "#" + encodeURIComponent(block.anchor);
    }
    return url;
  }

  function highlightContent(root, tokens) {
    if (!root || tokens.length === 0) return;
    var pattern = tokens
      .filter(function (token) { return token.length > 1; })
      .map(function (token) { return escapeRegex(token); })
      .join("|");
    if (!pattern) return;

    var regex = new RegExp("(" + pattern + ")", "giu");
    var walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT);
    var nodes = [];
    while (walker.nextNode()) {
      nodes.push(walker.currentNode);
    }

    nodes.forEach(function (node) {
      var parent = node.parentNode;
      regex.lastIndex = 0;
      if (!parent || !node.nodeValue || !regex.test(node.nodeValue)) return;
      regex.lastIndex = 0;
      if (parent.closest && parent.closest("math, script, style, mark.search-highlight")) return;

      var fragment = document.createDocumentFragment();
      var lastIndex = 0;
      node.nodeValue.replace(regex, function (match, _group, offset) {
        if (offset > lastIndex) {
          fragment.appendChild(document.createTextNode(node.nodeValue.slice(lastIndex, offset)));
        }
        var mark = document.createElement("mark");
        mark.className = "search-highlight";
        mark.textContent = match;
        fragment.appendChild(mark);
        lastIndex = offset + match.length;
        return match;
      });
      if (lastIndex < node.nodeValue.length) {
        fragment.appendChild(document.createTextNode(node.nodeValue.slice(lastIndex)));
      }
      parent.replaceChild(fragment, node);
    });
  }

  function focusSearchTarget() {
    if (!window.location.hash) return;
    var id;
    try {
      id = decodeURIComponent(window.location.hash.slice(1));
    } catch (_error) {
      id = window.location.hash.slice(1);
    }
    var target = document.getElementById(id);
    if (!target || !target.closest(".content")) return;
    target.classList.add("search-target");
    requestAnimationFrame(function () {
      target.scrollIntoView({ block: "center" });
    });
  }

  function renderResults(query) {
    var summary = document.getElementById("search-summary");
    var resultsRoot = document.getElementById("search-results");
    if (!summary || !resultsRoot) return;

    var rawIndex = window.SEARCH_INDEX;
    var pages = rawIndex && rawIndex.pages ? rawIndex.pages : [];
    var normalizedQuery = normalizeText(query);
    var tokens = tokenize(query);

    if (!normalizedQuery) {
      summary.textContent = "Enter a word or phrase to search the notes.";
      renderEmpty(resultsRoot, "Search results will appear here.");
      return;
    }

    var ranked = [];
    pages.forEach(function (page) {
      var scoreForTitle = titleScore(page, normalizedQuery, tokens);
      var pageHasPassage = false;
      (page.blocks || []).forEach(function (block) {
        var scoreForBlock = blockScore(block, normalizedQuery, tokens);
        if (scoreForBlock <= 0) return;
        pageHasPassage = true;
        ranked.push({
          page: page,
          block: block,
          score: scoreForBlock + Math.min(scoreForTitle, 400)
        });
      });
      if (!pageHasPassage && scoreForTitle > 0) {
        ranked.push({ page: page, block: null, score: scoreForTitle });
      }
    });

    ranked.sort(function (a, b) {
      if (b.score !== a.score) return b.score - a.score;
      return a.page.title.localeCompare(b.page.title);
    });

    var resultLimit = 200;
    var pageCount = new Set(ranked.map(function (entry) { return entry.page.path; })).size;
    var resultCount = ranked.length + " result" + (ranked.length === 1 ? "" : "s");
    if (ranked.length > resultLimit) resultCount = "the first " + resultLimit + " of " + resultCount;
    summary.textContent = "Showing " + resultCount + " on " + pageCount + " page" + (pageCount === 1 ? "" : "s") + ' for "' + query + '"';

    if (ranked.length === 0) {
      renderEmpty(resultsRoot, "No matches found. Try a shorter phrase or a page title.");
      return;
    }

    var groups = [];
    var groupsByPath = new Map();
    ranked.slice(0, resultLimit).forEach(function (entry) {
      var group = groupsByPath.get(entry.page.path);
      if (!group) {
        group = { page: entry.page, entries: [] };
        groupsByPath.set(entry.page.path, group);
        groups.push(group);
      }
      group.entries.push(entry);
    });

    resultsRoot.innerHTML = groups.map(function (group) {
      var page = group.page;
      var passages = group.entries.map(function (entry) {
        var block = entry.block;
        var snippetHtml = snippetHtmlForBlock(block, tokens) || "<p>" + highlightText(page.title, tokens) + "</p>";
        return [
          '<li class="search-result-passage">',
          '<a class="search-result-match" href="' + escapeHtml(buildResultUrl(page, block, query)) + '">',
          '<div class="search-result-snippet">' + snippetHtml + "</div>",
          "</a>",
          "</li>"
        ].join("");
      }).join("");
      return [
        '<article class="search-result">',
        '<h2 class="search-result-title"><a href="' + escapeHtml(buildResultUrl(page, null, query)) + '">' + highlightText(page.title, tokens) + "</a></h2>",
        '<p class="search-result-link">' + escapeHtml("/" + page.route) + "</p>",
        '<ol class="search-result-passages">' + passages + "</ol>",
        "</article>"
      ].join("");
    }).join("");
  }

  function syncSearchForms() {
    var params = new URLSearchParams(window.location.search);
    var query = params.get("q") || params.get("search") || "";

    document.querySelectorAll('form[data-search-form="true"]').forEach(function (form) {
      var input = form.querySelector('input[name="q"]');
      if (input && !input.value) {
        input.value = query;
      }
    });
  }

  function initSearchPage() {
    if (!document.getElementById("search-summary") || !document.getElementById("search-results")) return;
    var params = new URLSearchParams(window.location.search);
    renderResults(params.get("q") || "");
  }

  function initPageHighlights() {
    if (document.getElementById("search-summary") && document.getElementById("search-results")) return;
    var params = new URLSearchParams(window.location.search);
    var query = params.get("search") || "";
    if (!query) return;
    highlightContent(document.querySelector(".content"), tokenize(query));
    focusSearchTarget();
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", function () {
      syncSearchForms();
      initSearchPage();
      initPageHighlights();
    }, { once: true });
  } else {
    syncSearchForms();
    initSearchPage();
    initPageHighlights();
  }
})();
