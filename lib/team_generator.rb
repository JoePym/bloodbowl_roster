class TeamGenerator

  def render
  	Prawn::Document.generate('hello.pdf') do |pdf| 
  	  pdf.text("Hello Prawn!") 
  	end
  end

end