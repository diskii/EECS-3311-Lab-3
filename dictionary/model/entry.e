note
	description: "Entry in a dictionary consisting of a search key and a value."
	author: "Jackie and Your"
	date: "$Date$"
	revision: "$Revision$"

class
	ENTRY[V, K]

create
	make

feature -- Attributes
	value: V
	key: K

feature -- Constructor
	make (v: V; k: K)
		do
			value := v
			key := k
		end

feature
	-- Your Task
	-- You may need to define/redefine feature(s) in this class.
end
