class TaskRoles

	def getTaskRolesList
		'lsaccfg -t taskrole -F "name"'
	end

	#mkaccfg -t taskrole -i "name=test1,parent=hmcsuperadmin,resources="
	def create(name, parent)
		"mkaccfg -t taskrole -i \"name=#{name},parent=#{parent},resources=\""
	end
	
end