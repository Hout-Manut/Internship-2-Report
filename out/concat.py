from pathlib import Path
from typing import Sequence

from PyPDF2 import PdfMerger


def merge_pdfs(input_paths: Sequence[Path], output_path: Path) -> None:
    merger = PdfMerger()
    try:
        for path in input_paths:
            merger.append(str(path))
        with output_path.open("wb") as out:
            merger.write(out)
    finally:
        merger.close()


if __name__ == "__main__":
    output_dir = next(Path(__file__).resolve().parent.parent.glob("out/"))
    header_file = output_dir / "report-header.pdf"
    body_file = output_dir / "report-body.pdf"
    output_file = output_dir.parent / "report.pdf"

    merge_pdfs([header_file, body_file], output_file)
