pdf.move_down(75)
pdf.text "#{@conference.name}", :size => 30, :style => :bold


@conference.delegates.each do |delegate|
  pdf.text "delegate.delegation.name"
  pdf.move_down(30)
end