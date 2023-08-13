import os
from django.apps import apps
import magic

def get_upload_path(instance, filename):
    Message = apps.get_model('chat', 'Message')

    if instance.message_type == Message.AUDIO:
        return os.path.join('audio', filename)
    elif instance.message_type == Message.IMAGE:
        return os.path.join('images', filename)
    elif instance.message_type == Message.VIDEO:
        return os.path.join('videos', filename)
    elif instance.message_type == Message.DOCUMENT:
        return os.path.join('documents', filename)
    else:
        return os.path.join('other', filename)
    

# Helper function to determine file category
def determine_file_category(file):
    # Categorizations
    image_types = [
        "image/jpeg",
        "image/png",
        "image/gif",
        "image/bmp",
        "image/svg+xml",
        "image/webp"
    ]
    audio_types = [
        "audio/mpeg",
        "audio/x-wav",
        "audio/webm",
        "audio/ogg",
        "audio/aac",
        "audio/flac"
    ]
    video_types = [
        "video/mp4",
        "video/x-matroska",
        "video/webm",
        "video/ogg",
        "video/quicktime",
        "video/3gpp",
        "video/3gpp2",
        "video/avi",
        "video/msvideo",
        "video/x-msvideo",
        "video/mpeg",
        "video/x-flv"
    ]
    document_types = [
        "text/plain",
        "text/csv",
        "text/rtf",
        "text/html",
        "application/pdf",
        "application/msword",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "application/vnd.ms-excel",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        "application/vnd.ms-powerpoint",
        "application/vnd.openxmlformats-officedocument.presentationml.presentation",
        "application/epub+zip",
        "application/zip",
        "application/x-rar-compressed",
        "application/x-tar",
        "application/x-bzip2"
    ]
    
    file_mime = magic.from_buffer(file.read(1024), mime=True)

    # Reset file's pointer to the beginning after reading
    file.seek(0)

    if file_mime in image_types:
        return 'image'
    elif file_mime in audio_types:
        return 'audio'
    elif file_mime in video_types:
        return 'video'
    elif file_mime in document_types:
        return 'document'
    else:
        return None