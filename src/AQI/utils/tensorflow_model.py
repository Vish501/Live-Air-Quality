import tensorflow as tf

from AQI.utils.logger import get_logger
from AQI.utils.common import create_directories
from typeguard import typechecked as ensure_annotations          # Enforces runtime validation of the function’s argument and return types
from pathlib import Path

logger = get_logger()

@ensure_annotations
def save_tf_model(save_path: Path, model: tf.keras.Model) -> None:
    """
    Saves a given TensorFlow model to the specified path.

    Parameters:
    - save_path (Path): Full path where the model should be saved.
    - model (tf.keras.Model): Trained TensorFlow model to save.

    Raises:
    - ValueError: If the model is not a valid tf.keras.Model.
    - FileNotFoundError: If the save path parent directory is invalid or cannot be created.
    - PermissionError: If the directory exists but write access is denied.
    - OSError: For other OS-related issues like disk full.
    - Exception: For any other unforeseen errors.
    """
    try:
        # Ensure the parent directory exists
        create_directories([save_path.parent])

        # Save model
        model.save(save_path, save_format="keras")
        logger.info(f"Model saved at: {save_path}")

    except ValueError as exception_error:
        logger.error(f"Invalid model object passed for saving at {save_path}: {exception_error}")
        raise

    except FileNotFoundError:
        logger.error(f"Directory does not exist and could not be created: {save_path.parent}")
        raise

    except PermissionError as exception_error:
        logger.error(f"Permission denied while saving model at {save_path}: {exception_error}")
        raise

    except OSError as exception_error:
        logger.error(f"OS error while saving the model at {save_path}: {exception_error}")
        raise
    
    except Exception as exception_error:
        logger.error(f"Unexpected error while saving the model at {save_path}: {exception_error}")
        raise
