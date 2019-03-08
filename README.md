# TPHP
PHP Engine written in Pascal. PHP version required 5.3+ and up.
This engine is based on [CodeThurst](https://github.com/RooviTech/CodeThurst/).

# Building 
RAD Studio version: 10.3 Rio.
1. Open **TPHP.dproj** or **TPHP.dpr** in your RAD Studio.
2. Click Project->Compile, Completed!, Executable file will be located in the **"build/executables"** path.
3. It remains only to put php5ts.dll version 5.3 and up and above near TPHP.exe. PHP 5.6.40 is present by default.

# Runing
By default (when no params) engine run file "core/include.php".
To run other file you can execute the command:
```bat
TPHP.exe <path/to/php.script>
```

# Comand line interface
If you need to display help message, you can execute the command:
```bat
TPHP.exe -h
```