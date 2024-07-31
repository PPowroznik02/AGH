from pathlib import Path

import logging


class logger_helper:

    def __init__(self, name, level=logging.INFO):
        # create a custom logger
        self.logger = logging.getLogger(name)
        self.logger.setLevel(level)


        # create handlers
        c_handler = logging.StreamHandler()
        logs_file = Path(__file__).absolute().parents[2] / "logs"
        if not logs_file.exists():
            logs_file.mkdir(parents=True, exist_ok=True)
        f_handler = logging.FileHandler(logs_file / "logfile.log", encoding='utf-8')
        c_handler.setLevel(logging.INFO)
        f_handler.setLevel(logging.DEBUG)

        # create formatters and add it to handlers
        c_format = logging.Formatter("%(name)s - %(levelname)s - %(message)s")
        f_format = logging.Formatter(
            "%(asctime)s.%(msecs)03d - %(name)s - %(levelname)s - %(message)s",
            datefmt="%Y-%m-%d %H:%M:%S",
        )
        c_handler.setFormatter(c_format)
        f_handler.setFormatter(f_format)

        # add handlers to the logger
        self.logger.addHandler(c_handler)
        self.logger.addHandler(f_handler)

    def log(self, level, message):
        if level == logging.DEBUG:
            self.logger.debug(message)
        elif level == logging.INFO:
            self.logger.info(message)
        elif level == logging.WARNING:
            self.logger.warning(message)
        elif level == logging.ERROR:
            self.logger.error(message)
        elif level == logging.CRITICAL:
            self.logger.critical(message)
