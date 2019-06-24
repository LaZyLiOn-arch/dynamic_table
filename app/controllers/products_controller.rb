class ProductsController < ApplicationController

	require 'csv'
	before_action :update_csv


  def index
  	@csv_table = CSV.open(Rails.root.join('lib', 'seeds', 'products.csv'), :headers => true).read
  end

  def save_data
  	rows = CSV.read(Rails.root.join('lib', 'seeds', 'products.csv'), headers: true).collect do |row|
  		row.to_hash
		end
		headers = rows.first.keys
		new_csv = CSV.generate do |csv|
	  		csv << headers
			  rows.each do |row|
			  	if row["Id"].eql?(params["id"])
			    	csv << [params["id"],params["Product Name"], params["Description"], params["Brand Name"]]
			    	next
			    else
			      csv << row.values
			    end
			  end
		end
		File.open(Rails.root.join('lib', 'seeds', 'products.csv'), 'w') { |file| file.write(new_csv) }
		redirect_to 'products#index'
  end


  def create_row
  	rows = CSV.read(Rails.root.join('lib', 'seeds', 'products.csv'), headers: true).collect do |row|
  		row.to_hash
		end
		headers = rows.first.keys
		new_csv = CSV.generate do |csv|
	  		csv << headers
	  		id = "0"
			  rows.each do |row|
			    	csv << row.values
			    	id = row.values[0]
			  end
			  csv << [(id.to_i+1).to_s, params["Product Name"], params["Description"], params["Brand Name"]]
		end

		File.open(Rails.root.join('lib', 'seeds', 'products.csv'), 'w') { |file| file.write(new_csv) }
  end

  def delete_row
  	rows = CSV.read(Rails.root.join('lib', 'seeds', 'products.csv'), headers: true).collect do |row|
  		row.to_hash
		end
		headers = rows.first.keys
		new_csv = CSV.generate do |csv|
	  		csv << headers
			  rows.each do |row|

			  	unless row["Id"].eql?(params["id"])
			      csv << row.values
			    end
			  end
		end
		File.open(Rails.root.join('lib', 'seeds', 'products.csv'), 'w') { |file| file.write(new_csv) }
  end

  private
  def update_csv
		id = 1
		rows = CSV.read(Rails.root.join('lib', 'seeds', 'products.csv'), headers: true).collect do |row|
  		row.to_hash
		end
		unless rows.empty?
			headers = rows.first.keys
			unless headers.include?("Id")
				column_names = headers.unshift("Id")
				new_csv = CSV.generate do |csv|
		  		csv << column_names
				  rows.each do |row|
				    values = row.values.unshift(id)
				    csv << values
				    id += 1
				  end
				end
				File.open(Rails.root.join('lib', 'seeds', 'products.csv'), 'w') { |file| file.write(new_csv) }
			end
	  end
	end
end

