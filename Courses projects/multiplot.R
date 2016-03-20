# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL, title=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  # all rows have the same height
  layoutHeights <- rep(1, nrow(layout))
  
  # if title, we add a first row & fix it to 1/4 of the other heigths
  if (!is.null(title)) {
    layout <- rbind(rep(0, ncol(layout)), layout)
    layoutHeights <- c(0.1 * sum(layoutHeights), layoutHeights)
  }
  
  #if (numPlots==1) {
  #  print(plots[[1]])
  #} 
  #else {
  
  # Set up the page
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout), heights = (unit(layoutHeights, "null")))))
  
  #title
  if (!is.null(title)) {
    matchidx <- as.data.frame(which(layout == 0, arr.ind = TRUE))
    grid.text(title, vp = viewport(layout.pos.row = matchidx$row, 
                                   layout.pos.col = matchidx$col))
  }
  
  # Make each plot, in the correct location
  for (i in 1:numPlots) {
    # Get the i,j matrix positions of the regions that contain this subplot
    matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
    
    print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                    layout.pos.col = matchidx$col))
  }
  
  #}
}