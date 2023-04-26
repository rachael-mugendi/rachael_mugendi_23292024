from flask import Flask, request, jsonify
import firebase_admin
from firebase_admin import credentials, firestore


app = Flask(__name__)


cred = credentials.Certificate("key.json")
firebase_admin.initialize_app(cred)

# Get a reference to the Firestore database
db = firestore.client()

#create profile
@app.route('/profiles', methods=['POST'])
def create_profile():
    # Parse the request body into a dictionary
    data = request.get_json()


    # Add the new profile to the Firestore database
    db.collection('profiles').document(data['id']).set({
        'id': data['id'],
        'name': data['name'],
        'email': data['email'],
        'password' : data['password'],
        'major' : data['major'],
        'year_group' : data['year_group'],
        'date_of_birth': data['date_of_birth'],
        'on_offcampus': data['on_offcampus'],
        'best_food': data['best_food'],
        'best_movie' : data['best_movie']
    })

    # Return the new profile as a JSON response
    return jsonify({'message': 'Profile created successfully'}), 201

#edit profile section
@app.route('/profiles', methods=['PUT'])
def create_or_updateprofile():
    # Parse the request body into a dictionary
    data = request.get_json()

    # Add or update the profile in the Firestore database
    db.collection('profiles').document(data['id']).set({
        'id': data['id'],
        'name': data['name'],
        'email': data['email'],
        'password' : data['password'],
        'major' : data['major'],
        'year_group' : data['year_group'],
        'date_of_birth': data['date_of_birth'],
        'on_offcampus': data['on_offcampus'],
        'best_food': data['best_food'],
        'best_movie' : data['best_movie']
    }, merge=True)

    # Return the updated profile as a JSON response
    return jsonify({'message': 'Profile updated successfully'}), 201


#show profile
@app.route('/profiles/<string:profile_id>', methods=['GET'])
def get_profile(profile_id):
    # Retrieve the profile from the Firestore database
    profile_doc = db.collection('profiles').document(profile_id).get()

    # Check if the profile exists
    if not profile_doc.exists:
        return jsonify({'error': 'Profile not found'}), 404

    # Return the profile as a JSON response
    profile_data = profile_doc.to_dict()
    return jsonify(profile_data), 200

#show all profiles

@app.route('/profiles', methods=['GET'])
def get_profiles():
    # Retrieve all profiles from the Firestore database
    profiles = db.collection('profiles').get()

    # Check if any profiles exist
    if len(profiles) == 0:
        return jsonify({'error': 'No profiles found'}), 404

    # Create a list to store all the profiles
    profiles_list = []

    # Loop through all profiles and append them to the list
    for profile in profiles:
        profile_data = profile.to_dict()
        profiles_list.append(profile_data)

    # Return the profiles list as a JSON response
    return jsonify(profiles_list), 200






#make a post
@app.route('/posts', methods=['POST'])
def create_post():
    # Parse the request body into a dictionary
    data = request.get_json()


    # Add the new profile to the Firestore database
    db.collection('posts').document(data['postId']).set({
        'postId': data['postId'],
        'title': data['title'],
        'content': data['content'],
        'email': data['email'],

    })

    # Return the new profile as a JSON response
    return jsonify({'message': 'Posts created successfully'}), 201


#show all posts
@app.route('/posts', methods=['GET'])
def get_posts():
    # Query the posts collection in Firestore
    posts_ref = db.collection('posts')
    posts = [doc.to_dict() for doc in posts_ref.stream()]

    # Return the list of posts as a JSON response
    return jsonify(posts), 200



if __name__ == '__main__':
    app.run(debug=True)
