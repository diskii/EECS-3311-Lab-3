note
	description: "Summary description for {ENTRY_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENTRY_ITERATION_CURSOR[V,K]
inherit
	ITERATION_CURSOR[ENTRY[V,K]]
create
	make
feature{NONE} --cursor
	--imp:ARRAY[ENTRY[V,K]]

	index:INTEGER
	array: ARRAY[V]
	ln: LINKED_LIST[K]

feature
	make(values: ARRAY[V];keys: LINKED_LIST[K])
		do
			array := values
			ln := keys
			index := values.lower
		end
feature -- Access

	item: ENTRY[V,K]
		-- Item at current cursor position.
		do
			create Result.make (array[index],ln[index])

		end

feature -- Status report	

	after: BOOLEAN
		-- Are there no more items to iterate over?
		do
			Result:= array.count < index
		end

feature -- Cursor movement

	forth
			-- Move to next position.
		do
			index:= index + 1
		end


end

