# include neccesary files
require 'rmagick'
include Magick

# some constants
Rows = 128
Cols = 320
XOffsetForText = 5
YOffsetForText = 40
XOffsetForLogo = 10
YOffsetForLogo = 0
GradStart = "#900"
GradEnd = "#000"

# some parameters
pName = "Rupak Ganguly\n" 
pRole = "Rails Magazine Core Team\n"
pMessage = "www.railsmagazine.com"
pOutputfile = "c:\\users\\rupak\\pictures\\badge.jpg"
pLogofile = "c:\\users\\rupak\\pictures\\rmlogo.png"

# define the contributor badge function
def make_badge(name, role, message, outputfile, logofile)

  # create the text to composite
  text = name + role + message
  
  # create a new gradient background
  fill = Magick::GradientFill.new(0, 0, 0, Rows, GradStart, GradEnd)
  img = Magick::Image.new(Cols, Rows, fill);
  
  # read the logo file
  logo_img = Magick::Image.read(logofile).first
  #puts img.inspect
  
  # composite the logo image on the gradient background
  #img = img.composite(logo_img, Magick::WestGravity, Magick::OverCompositeOp)
  img = img.composite(logo_img, XOffsetForLogo, YOffsetForLogo, Magick::OverCompositeOp)
  
  # Annotate the filled image with the code that created the fill.
  annText = Magick::Draw.new
  annText.annotate(img, 0, 0, XOffsetForText, YOffsetForText, text) {
      self.gravity = Magick::NorthEastGravity
      self.fill = 'white'
      self.stroke = 'transparent'
      self.pointsize = 14
      }
  
  #img.display
  img.write(outputfile)

  exit
  
end

# call the contributor badge function
make_badge(pName, pRole, pMessage, pOutputfile, pLogofile)
