# in Rails, any methods defined in the helper file are available in any corresponding view
module UsersHelper
    def gravatar_for(user, options = { size: 80 } )
        # gravatar urls are based on md5 hashes of the user's email. 
        # In Ruby, the md5 algorithm is implemented using the hexdigest method, which is part of the digest library
        # our helper code, returns an image tag for the gravatar with a gravatar css class and all text equal to the user's name
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase) # we want the argument to hexdigest to be all lowercase
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end
end
