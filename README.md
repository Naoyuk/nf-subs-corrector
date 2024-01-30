# nf-subs-corrector

## Overview

`nf-subs-corrector` is a Ruby script designed to standardize the formatting of data collected through NinjaForms submissions. It addresses variations in the representation of each field within the CSV data.

## Usage

1. Save the CSV files obtained from NinjaForms submissions in the `/src` folder.
2. Execute the `exe/exe.rb` script.
3. The script will process all CSV files in the `/src` folder, standardize their formats, and save the corrected files in the `/output` folder.

## Installation
```bash
git clone https://github.com/Naoyuk/nf-subs-corrector
```

## How to Run

1. Open a terminal.
2. Navigate to the project directory.
3. Run the script by executing the following command:

    ```bash
    ruby exe/exe.rb
    ```

## License

This script is released under the MIT License. See [LICENSE](LICENSE) for more details.

## Contributors

- [Naoyuki Ishida](https://naoyuki-ishida.com)

## Issues

If you encounter any issues or have suggestions for improvements, please [open an issue](https://github.com/Naoyuk/nf-subs-corrector/issues).

## Acknowledgments

Special thanks to the NinjaForms community and contributors.

Happy correcting!
