# Set up instructions for this study

For more detailed instructions regarding how to set up to have your local environment compatible with CBIG repository, please see `CBIG/setup/readme.md`

A sample configuration `CBIG_TRBPC_tested_config_adapted.sh` is provided in this folder. Please:

1. Copy this sample configuration script and create a new folder to keep it, for example:

```
mkdir ~/setup
```

2. Open your newly copied configuration script with a text editor and change the environmental variables to point to the correct directories of the respective softwares (e.g. FreeSurfer and MATLAB) and associated repositories

3. Source your configuration script from `.bashrc` or `.cshrc`. In Bash, add the following line to `~/.bashrc`:

```
source ~/setup/CBIG_TRBPC_tested_config_adapted.sh
```

or in C-shell, add the following line to `~/.cshrc`:

```
source ~/setup/CBIG_TRBPC_tested_config_adapted.csh
```


