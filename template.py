import os
import logging

from pathlib import Path

logging.basicConfig(level=logging.INFO, format='[%(asctime)s]: %(message)s:')

# List of files and directories that need to be created or amended with new files
list_of_files = [
    "src/AQI/__init__.py",
    "src/AQI/components/__init__.py",
    "src/AQI/utils/__init__.py",
    "src/AQI/utils/common.py",
    "src/AQI/utils/logger.py",
    "src/AQI/config/__init__.py",
    "src/AQI/config/configurations.py",
    "src/AQI/pipeline/__init__.py",
    "src/AQI/entity/__init__.py",
    "src/AQI/constants/__init__.py",
    "config/config.yaml",
    "params/params.yaml",
    "pyproject.toml",
    "requirements.txt",
    "notebooks/.gitkeep",
    "app.py"
]

# Iterate through each file path
for filepath in list_of_files:
    filepath = Path(filepath)
    filedir, _ = os.path.split(filepath)
    
    # Create the directory if it doesn't already exist
    if filedir != "":
        os.makedirs(filedir, exist_ok=True)
        logging.info(f'Creating directory: {filedir}')
    
    # Create the file if it doesn't exist or is currently empty
    if not filepath.exists() or filepath.stat().st_size == 0:
        filepath.touch()
        logging.info(f"Created empty file: {filepath}")
    else:
        logging.info(f"File already exists: {filepath}")
