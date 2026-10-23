#asset("assets/site.css", read("/src/assets/site.css"))
#asset("assets/site.js", read("/src/assets/site.js"))
#asset("assets/search.css", read("/src/assets/search.css"))
#asset("assets/search.js", read("/src/assets/search.js"))
#for font-path in (
  "Lato/Lato-Hairline.woff2",
  "Lato/Lato-HairlineItalic.woff2",
  "Lato/Lato-Thin.woff2",
  "Lato/Lato-ThinItalic.woff2",
  "Lato/Lato-Light.woff2",
  "Lato/Lato-LightItalic.woff2",
  "Lato/Lato-Regular.woff2",
  "Lato/Lato-Italic.woff2",
  "Lato/Lato-Medium.woff2",
  "Lato/Lato-MediumItalic.woff2",
  "Lato/Lato-Semibold.woff2",
  "Lato/Lato-SemiboldItalic.woff2",
  "Lato/Lato-Bold.woff2",
  "Lato/Lato-BoldItalic.woff2",
  "Lato/Lato-Heavy.woff2",
  "Lato/Lato-HeavyItalic.woff2",
  "Lato/Lato-Black.woff2",
  "Lato/Lato-BlackItalic.woff2",
  "Lato/LICENSE.txt",
  "LeteSansMath/LeteSansMath.woff2",
  "LeteSansMath/LeteSansMath-Bold.woff2",
  "LeteSansMath/LICENSE.txt",
  "RobotoMono/RobotoMono-VariableFont_wght.woff2",
  "RobotoMono/RobotoMono-Italic-VariableFont_wght.woff2",
  "RobotoMono/OFL.txt",
) {
  asset("assets/fonts/" + font-path, read("/src/assets/fonts/" + font-path, encoding: none))
}
#asset("assets/github.svg", read("/src/assets/github.svg"))
#asset("assets/search.svg", read("/src/assets/search.svg"))
#asset("assets/print.svg", read("/src/assets/print.svg"))
#asset("assets/download.svg", read("/src/assets/download.svg"))
#asset("assets/eye.svg", read("/src/assets/eye.svg"))
#asset("assets/sun.svg", read("/src/assets/sun.svg"))
#asset("assets/moon.svg", read("/src/assets/moon.svg"))
#asset("assets/theme.svg", read("/src/assets/theme.svg"))
#asset("assets/menu.svg", read("/src/assets/menu.svg"))
#asset("assets/toc.svg", read("/src/assets/toc.svg"))
