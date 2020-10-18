class Character < ApplicationRecord

## CONSTANTS ##################################################################
	STATUS_ALIVE=1
	STATUS_DEAD=2
	STATUS_UNKNOWN=3

	STR_STATUS_ALIVE="Alive".freeze
	STR_STATUS_DEAD="Dead".freeze
	STR_STATUS_UNKNOWN="unknown".freeze

## SCOPES #####################################################################
	default_scope { order(:id) }

## ASSOCIATIONS ###############################################################
	has_and_belongs_to_many :episodes

## VALIDATIONS ################################################################
	validates_presence_of :name, :status, :image
	validates_inclusion_of :status, in: STATUS_ALIVE..STATUS_UNKNOWN
	validates_associated :episodes

## PUBLIC CLASS METHODS #######################################################
	def self.status_from_str(str_status)
		# Returns the integer status value from its string representation
		status = STATUS_UNKNOWN
		case str_status
		when STR_STATUS_ALIVE
			status = STATUS_ALIVE
		when STR_STATUS_DEAD
			status = STATUS_DEAD
		when STR_STATUS_UNKNOWN
			status = STATUS_UNKNOWN
		else
			raise SageTest.new("Wrong character's status: #{str_status}")
		end
		status
	end

## PUBLIC OBJECT METHODS ######################################################
	def status_to_str
		# Returns the string value of the status attribute
		str_status = STR_STATUS_UNKNOWN
		case self.status
		when STATUS_ALIVE
			str_status = STR_STATUS_ALIVE
		when STATUS_DEAD
			str_status = STR_STATUS_DEAD
		when STATUS_UNKNOWN
			str_status = STR_STATUS_UNKNOWN
		else
			raise Exceptions::SageTestError.new("Wrong character's status: #{status}")
		end
		str_status
	end

	def to_s
		self.name
	end

end