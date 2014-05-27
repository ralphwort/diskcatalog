class FileList < ActiveRecord::Base

	def self.starts_with(filename, disk)
		where("disk = ? and filename like ?", disk, "#{filename}%")
  end

	def self.ends_with(filename, disk)
		where("disk = ? and filename like ?", disk, "%#{filename}")
  end

	def self.contains(filename, disk)
		where("disk = ? and filename like ?", disk, "%#{filename}%")
  end

	def self.starts_with_all_disks(filename)
		where("filename like ?", "#{filename}%")
  end

	def self.ends_with_all_disks(filename)
		where("filename like ?", "%#{filename}")
  end

	def self.contains_all_disks(filename)
		where("filename like ?", "%#{filename}%")
  end

  def self.all_for_disk(disk)
		where("disk like ?", disk)
  end
end
