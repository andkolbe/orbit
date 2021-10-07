# modules provide us with a way to package together related methods. 
# these methods can then be added to Ruby classes using the keyword include
# normally, you explicitly include modules yourself, but as this is a helper module, Rails takes care of the inclusion for us
module ApplicationHelper
    # returns a full title on a per page basis

    # Method definition, optional argument
    def full_title(page_title = ' ')
        # creating and assigning a variable
        base_title = 'Orbit Feedback Application'
        # boolean test
        if page_title.empty?
            # implicit return
            base_title
        else
            # string concatenation
            page_title + ' | ' + base_title
        end
    end
end
