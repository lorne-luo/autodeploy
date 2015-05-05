__author__ = 'Lorne'
import shutil
from zipfile import ZipFile
import zipfile
import os
import urllib
from hashlib import md5

from autodeploy.settings import PUPPET_ROOT_PATH, STATIC_URL, DJANGO_ROOT_URL



#unzip file
def unzip(source_zip, target_dir):
    zip_file = ZipFile(source_zip)
    for f in zip_file.filelist:
        if f.compress_type == 0 and f.compress_size == 0:
            continue
        file_path = os.path.join(target_dir, f.filename)
        dir_path = os.path.dirname(file_path)
        if not os.path.exists(dir_path):
            os.makedirs(dir_path)
        if file_path.endswith('/') or file_path.endswith('\\'):
            continue
        f_handle = open(file_path, "wb")
        f_handle.write(zip_file.read(f.filename))
        f_handle.close()
    zip_file.close()


# add file into exist zip
def add_file_zip(file, zip_file):
    f = zipfile.ZipFile(zip_file, 'w', zipfile.ZIP_DEFLATED)
    f.write(file)
    f.close()


# zip dir
def zip_dir(target_dir, zip_file):
    if os.path.exists(zip_file):
        shutil.rmtree(zip_file)
    zip = zipfile.ZipFile(zip_file, 'w', zipfile.ZIP_DEFLATED)
    rootlen = len(os.path.dirname(target_dir)) + 1
    for dirpath, dirnames, filenames in os.walk(target_dir):
        for filename in filenames:
            fn = os.path.join(dirpath, filename)
            zip.write(fn, fn[rootlen:])
    zip.close()


def md5_file(name):
    m = md5()
    a_file = open(name, 'rb')
    m.update(a_file.read())
    a_file.close()
    return m.hexdigest()


def generate_url_md5(obj):
    file_path = str(obj.package.path)
    puppet_root = PUPPET_ROOT_PATH.replace('\\', '/')
    relative_url = file_path.replace('\\', '/').replace(puppet_root, '')
    if len(relative_url) > 1:
        relative_url = relative_url[1:] if relative_url[0] == '/' else relative_url
    url = DJANGO_ROOT_URL + STATIC_URL + relative_url
    obj.package_url = url
    obj.package_md5 = md5_file(obj.package.path)
    obj.save()


def path_to_url(path):
    puppet_root = PUPPET_ROOT_PATH.replace('\\', '/')
    relative_url = path.replace('\\', '/').replace(puppet_root, '')
    if len(relative_url) > 1:
        relative_url = relative_url[1:] if relative_url[0] == '/' else relative_url
    url = DJANGO_ROOT_URL + STATIC_URL + relative_url
    return url


def download_package(obj):
    relative_url = obj.package_url.replace(DJANGO_ROOT_URL, '').replace(STATIC_URL, '')
    local_path = PUPPET_ROOT_PATH + '/' + relative_url
    local_path = local_path.replace('//', '/')
    if not os.path.exists(local_path) or md5_file(local_path) != obj.package_md5:
        if not os.path.exists(os.path.dirname(local_path)):
            os.makedirs(os.path.dirname(local_path))
        urllib.urlretrieve(obj.package_url, local_path)
        print 'download %s from %s!' % (local_path, obj.package_url)
    else:
        print local_path + ' have already exist!'

    # for test
    if __name__ == '__main__':
        s = md5_file('E:\\workspace\\TangoRequirement\\autodeploy\\Jazz_1.6.zip')
        print s
        print len(s)
        #zip_dir('E:\\workspace\\TangoRequirement\\autodeploy\\templates',
        #        'E:\\workspace\\TangoRequirement\\autodeploy\\static.zip')
        #
        #unzip('E:\\workspace\\TangoRequirement\\autodeploy\\static.zip',
        #      'E:\\workspace\\TangoRequirement\\autodeploy\\test')

