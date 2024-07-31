import argparse


def parse_args():
    parser = argparse.ArgumentParser(description="Module to work with the arguments of the ambulance program")
    parser.add_argument("--text", "-t", help="Text to show")
    parser.add_argument("--ambulance", "-a", required=True)
    parser.add_argument("--station", "-s", required=True)
    parser.add_argument("--incident", "-i", required=True)
    parser.add_argument("--driver", "-d", required=True)
    parser.add_argument("--employee", "-e", required=True)

    return parser.parse_args()