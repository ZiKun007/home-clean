c = get_config()
c.InteractiveShellApp.exec_lines = [
    "import os",
    "os.environ['IPYTHONDIR'] = os.path.join(os.environ['XDG_CONFIG_HOME'], 'ipython')"
]
