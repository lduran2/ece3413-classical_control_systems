# for extension splitter
import os

def target_dir(filename_ext):
    r'''
     Formats a target directory name from the given filename and
     extension as '{filename}_{extension}'.
     '''
    # get the filename without extension for the directory name
    filename, ext = os.path.splitext(filename_ext)
    # check that there's an extension
    if (''==ext):
        raise NoExtensionOnFile(filename_ext)
    # end if (''==ext)
    # create the directory name
    return f'{filename}_{ext[1:]}'
# end def target_dir(filename_ext)

class NoExtensionOnFile(Exception):
    def __init__(self, filename_ext, *args):
        super().__init__(args)
        self.filename_ext = filename_ext

    def __str__(self):
        return self.filename_ext
# end class NoExtension(Exception)
