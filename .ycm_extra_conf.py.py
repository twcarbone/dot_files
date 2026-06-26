import pathlib


def venv_path() -> pathlib.Path:
    return pathlib.Path(".venv")


def python_bin() -> str:
    return str(venv_path().joinpath("bin").joinpath("python3"))


def site_packages() -> list[str]:
    return [str(path) for path in venv_path().glob("lib/*/site-packages/*")]


def Settings(**kwargs):
    return {
        "sys_path": site_packages(),
        "interpreter_path": python_bin(),
    }


if __name__ == "__main__":
    print(Settings())
