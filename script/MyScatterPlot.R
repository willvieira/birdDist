#Scatter plot
myplot <- function(x,
                   y,
                   xlab = NULL,
                   ylab = NULL,
                   xlim = NULL,
                   ylim = NULL,
                   type = NULL,
                   col = NULL, #color
                   main = NULL,
                   aAdjx = NULL, #adj the distance between the axis and the ticks of 'x'
                   aAdjy = NULL, #idem for 'y'
                   pointCex = NULL, #size of ploted points
                   pch = NULL,
                   width = NULL, #Size of the plot window, default = 4.5
                   height = NULL, #Size of the plot window, default = 4
                   newWindow = NULL) { #NULL = FALSE

  #lab text
  textx <- xlab
  texty <- ylab
  Title <- main

  #Test
  if(is.null(col)) {
    col = 'black'
  }else {
    col	= col
  }
  if(is.null(aAdjx)) {
    aAdjx = - 0.75
  }else{aAdjx <- aAdjx
  }
  if(is.null(aAdjy)) {
    aAdjy = - 0.75
  }else{aAdjy <- aAdjy
  }
  if(is.null(pointCex)) {
    pointCex = 0.8
  }else{pointCex <- pointCex
  }
  if(is.null(width)) {
    width = 4
  }else {
    width = width
  }
  if(is.null(height)) {
    height = 4
  }else {
    height = height
  }

  #plot graph
  if(is.null(newWindow)){
    dev.new(width = width, height = height)
  }
  par(family = 'serif', mar = c(2, 2.25, 1, 0)+ .24, cex = 1.2)
  plot(x, y, xlim = xlim, ylim = ylim, col = col, type = type, xaxt = 'n', yaxt = 'n', xlab = '', ylab = '', cex = pointCex, pch = pch)

  #plot ticks
  xx=axis(1, labels = FALSE, tck = -0.013)
  yy=axis(2, labels = FALSE, tck = -0.013)

  #x and y lab list
  lablistx <- xx
  lablisty <- yy

  #plot labels
  axis(1, at = lablistx, line = aAdjx, labels = lablistx, tck = - 0.04, lwd = 0)
  axis(2, at = lablisty, line = aAdjy, labels = lablisty, tck = - 0.04, lwd = 0)

  #plot x and y lab text
  mtext(side = 1, textx, line = 1.15, cex = 1.4)
  mtext(side = 2, texty, line = 1.10, cex = 1.4)

  #Title
  mtext(side = 3, Title, adj = 0.5, line = 0.05, cex = 1.6, font = 3)

}
