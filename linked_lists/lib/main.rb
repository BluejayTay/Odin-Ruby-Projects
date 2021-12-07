require_relative "linked_list"

linkster = LinkedList.new
linkster.append(50)
linkster.append(33)
linkster.prepend(5)
linkster.to_s
