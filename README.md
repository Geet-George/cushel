# cushel

Cushel is a collection of some useful shell aliases and functions that I find myself using often. This repository includes these conveniences in a `.cushel` file along with an install file (`install.sh`) that helps automatically add relevant lines to your `.bashrc` so that everything in `.cushel` is added to your configurations. Read on to see how to get this to work!

Simply add your bash customizations to `.cushel` and enjoy!

Side Note: It is called cushel, because:

1. It **cu**stomizes your **shel**l.
2. In German, *kuschel* means to be comfortable and cozy (I think also to cuddle?) and if you have your familiar bash commands in your work environment, it feels like a nice cozy place to be in, a bit like home rather than a harsh, unfamiliar bash env.
3. Alternatively, you can think of this as your own **cus**tomized **hel**l! 

In any case, have fun!

## Installation

To install cushel, follow these steps:

1. **Clone the Repository:**

    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2. **Run the Installation Script:** Execute the provided installation script to add the necessary lines to your `.bashrc`:

    ```bash
    ./install_cushel.sh
    ```

    Optionally, provide a custom path to your `.bashrc`:

    ```bash
    ./install_cushel.sh /path/to/custom/.bashrc
    ```

3. **Apply Changes:** After installation, either restart your terminal or run:

    ```bash
    source ~/.bashrc
    ```

## Backup

The installation script automatically create backups of your `.bashrc` file to prevent any messup of your bash configurations. Backups are saved as `~/.bashrc.bak_YYYYMMDD_HHMMSS`.

## Current Functions and Aliases

### `sqa`:

Alias to monitor SLURM jobs using `squeue` with automatic refreshing every second.

```bash
alias sqa='watch -n 1 "squeue -a"'
```

### `catless`:

A function that displays the contents of a file using `less`.

#### Usage:

```bash
catless [--last|-l PREFIX] [FILENAME]
```

#### Options:

- `--last` or `-l`: Displays the most recently modified file starting with the specified PREFIX.
- `FILENAME`: Directly specifies the file to display if no prefix is provided.

## Considerations

- **Dependencies:** Ensure you have `watch` and `less` installed on your system for the aliases and functions to work properly.
- **Compatibility:** This repository is primarily designed for Unix-like operating systems (Linux, macOS). It may require adjustments for compatibility with other systems.
- **Customization:** Feel free to modify the aliases and functions to better suit your workflow. Add your own aliases to the `.cushel` file.

## Contributing

If you would like to contribute to this repository, feel free to submit a pull request or open an issue to discuss changes.

## License

This project is licensed under the MIT License.
