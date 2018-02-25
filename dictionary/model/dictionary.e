note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	DICTIONARY[V, K]
inherit
	ITERABLE[TUPLE[V,K]]
create
	make
feature {INSTRUCTOR_DICTIONARY_TESTS} -- Do not modify this export status!
	-- You are required to implement all dictionary features using these two attributes.
	values: ARRAY[V]
	keys: LINKED_LIST[K]

feature -- Feature(s) required by ITERABLE
	-- Your Task
	-- See test_iterable_dictionary and test_iteration_cursor in INSTRUCTOR_DICTIONARY_TESTS.
	-- As soon as you make the current class iterable,
	-- define the necessary feature(s) here.
	new_cursor: ITERATION_CURSOR[TUPLE[V,K]]
		do
			create{TUPLE_ITERATION_CURSOR[V,K]} Result.make(values,keys)
		end

feature -- Alternative Iteration Cursor
	-- Your Task
	-- See test_another_cursor in INSTRUCTOR_DICTIONARY_TESTS.
	-- A feature another_cursor is expected to be defined here.
	another_cursor: ITERATION_CURSOR[ENTRY[V,K]]
		do
			create{ENTRY_ITERATION_CURSOR[V,K]} Result.make(values,keys)
		end
feature -- Constructor
	make
			-- Initialize an empty dictionary.
		do
			create values.make_empty
			create keys.make
			keys.compare_objects
			values.compare_objects
			-- Your task.
		ensure
			empty_dictionary: True -- Your task.
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values:
				values.object_comparison
		end

feature -- Commands

	add_entry (v: V; k: K)
			-- Add a new entry with key 'k' and value 'v'.
			-- It is required that 'k' is not an existing search key in the dictionary.
		require
			non_existing_key: True -- Your Task
		do
			-- Your Task
			values.force(v,values.count+1)
			keys.extend(k)
		ensure
			entry_added: True -- Your Task
				-- Hint: In the new dictionary, the associated value of 'k' is 'v'
		end

	remove_entry (k: K)
			-- Remove the corresponding entry whose search key is 'k'.
	require
			existing_key: True -- Your Task
		local
			i,j:INTEGER
			index:INTEGER
		--	temp_key: K
		do
			-- get the index of the keys(linked list)
			--temp_key:= k
			from
				i := 1
			until
				i >= values.count
			loop
				if
					k ~ keys[i]
				then
					index := i
					keys.go_i_th (i)
					keys.remove
				end
				i:= i + 1
				keys.forth
			end
		-- Now that the keys is removed, remove the values
			from
				j:= index
			until
				j >= values.count
			loop
				values[j] := values[j+1]
				j:= j + 1
			end
			values.remove_tail (1)

		ensure
			dictionary_count_decremented: values.count = old values.count -1  -- Your Task
			key_removed: True -- Your Task
		end


feature -- Queries

	count: INTEGER
			-- Number of entries in the dictionary.
		do
			Result:= values.count
		ensure
			correct_result: True -- Your Task
		end

	exists (k: K): BOOLEAN
			-- Does key 'k' exist in the dictionary?
		do
			Result:= keys.has(k)
		ensure
			correct_result: True -- Your Task
		end


	get_keys (v: V): ITERABLE[K]
			-- Return an iterable collection of keys that are associated with value 'v'.
			-- Hint: Refere to the architecture BON diagram of the Iterator Pattern, to see
			-- what classes can be used to instantiate objects that are iterable.
		local
			ln : LINKED_LIST[K]
			i : INTEGER
		do
			create ln.make
			from
				i:= 1
			until
				i = values.count + 1
			loop
				if values[i] ~ v then
					ln.extend (keys[i])
				end
				i:= i + 1
			end
		Result := ln
		ensure
			correct_result: True -- Your Task
				-- Hint: Since Result is iterable, go accross it and make sure
				-- that every key in that iterable collection has its corresponding
				-- value equal to 'v'. Remember that in this naive implementation
				-- strategy, an existing key and its associated value have the same index.
		end

	get_value (k: K): detachable V
			-- Return the assocated value of search key 'k' if it exists.
			-- Void if 'k' does not exist.
			-- Declaring "detachable" besides the return type here indicates that
			-- the return value might be void (i.e., null).
		local
			i : INTEGER
		do
			from
				i := 1
			until
				i = values.count +1
			loop
				if
					keys[i] ~ k
				then
					Result := values[i] -- values
				end
				i:= i + 1
			end

		ensure
			case_of_void_result: True -- Your Task
				-- Hint: What does it mean when the return value is void?
			case_of_non_void_result: True -- Your Task
				-- Hint: What does it mean when the return value is not void?
		end

invariant
	consistent_counts_of_keys_and_values:
		keys.count = values.count
	consistent_counts_of_imp_and_adt:
		keys.count = count
end
