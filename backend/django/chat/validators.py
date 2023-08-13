import magic
from django.core.exceptions import ValidationError


ACCEPTED_MIME_TYPES = [
    # Images
    "image/jpeg",
    "image/png",
    "image/gif",
    "image/bmp",
    "image/svg+xml",
    "image/webp",
    
    # Audio
    "audio/mpeg",  # MP3 format
    "audio/x-wav",
    "audio/webm",  # WebM format
    "audio/ogg",   # OGG format
    "audio/aac",   # AAC format
    "audio/flac",  # FLAC format
    
    # Videos
    "video/mp4",
    "video/x-matroska",  # MKV format
    "video/webm",
    "video/ogg",
    "video/quicktime",   # MOV format
    "video/3gpp",       # 3GP format
    "video/3gpp2",      # 3G2 format
    "video/avi",
    "video/msvideo",
    "video/x-msvideo",  # AVI format
    "video/mpeg",
    "video/x-flv",      # FLV format

    # Documents
    "text/plain",
    "text/csv",
    "text/rtf",
    "text/html",
    "application/pdf",
    "application/msword",  # DOC format
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",  # DOCX format
    "application/vnd.ms-excel",  # XLS format
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",  # XLSX format
    "application/vnd.ms-powerpoint",  # PPT format
    "application/vnd.openxmlformats-officedocument.presentationml.presentation",  # PPTX format
    "application/epub+zip",  # EPUB format
    "application/zip",
    "application/x-rar-compressed",  # RAR format
    "application/x-tar",  # TAR format
    "application/x-bzip2",  # BZ2 format
]

def validate_file_type(upload):
    file_type = magic.from_buffer(upload.read(1024), mime=True)

    if file_type not in ACCEPTED_MIME_TYPES:
        raise ValidationError("File type not supported.")
    
    upload.seek(0)  # Reset the file pointer to the beginning of the file