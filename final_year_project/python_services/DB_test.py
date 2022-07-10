#from firebase import firebase


import firebase_admin

#-------------night try ---------

#from firebase_admin import credentials
#from firebase_admin import storage
#
#cred = credentials.Certificate('serviceAccount.json')
#firebase_admin.initialize_app(cred, {
#    'storageBucket': 'crop-protection-9b61b.appspot.com'
#})
#
#bucket = storage.bucket()
#
#imagePath = "123.png"
#imageBlob = bucket.blob('image')
#imageBlob.upload_from_filename(imagePath)


from firebase_admin import credentials, initialize_app, storage, delete_app, get_app

def uploadImage():
    print("b")
    # Init firebase with your credentials
    cred = credentials.Certificate('python_services/serviceAccount.json')
    #check the Firebase app is  initilized or not
    try:
        default_app = get_app()
    except ValueError:
        default_app = initialize_app(cred, {'storageBucket': 'crop-protection-9b61b.appspot.com'})    
    # Put your local file path
    fileName = "./uploads/image.jpg"
    bucket = storage.bucket()
    blob = bucket.blob("image")
    blob.upload_from_filename(fileName)
    
    # Opt : if you want to make public access from the URL
    blob.make_public()
    print("your file url", blob.public_url)
    try:
        delete_app(default_app)
    except ValueError:
        pass
    print("\n\t\t\tupload done\n\n")

#uploadImage("../uploads/image.jpg")