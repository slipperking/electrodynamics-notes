import os
import subprocess
import sys

SKIP_FILES = {
    "build.py",
}


def main() -> None:
    root = os.path.dirname(os.path.abspath(__file__))
    py_files = []

    for dirpath, _, files in os.walk(root):
        for file_name in files:
            if file_name.endswith(".py"):
                if file_name in SKIP_FILES:
                    continue
                path = os.path.join(dirpath, file_name)
                py_files.append(path)

    py_files.sort()

    invocation_dir = os.getcwd()

    for path in py_files:
        print(f"Running {path}")
        result = subprocess.run([sys.executable, path], cwd=invocation_dir)
        if result.returncode != 0:
            print(f"script failed: {path} (exit code {result.returncode})", file=sys.stderr)
            sys.exit(result.returncode)

    print("all scripts completed successfully.")


if __name__ == "__main__":
    main()
