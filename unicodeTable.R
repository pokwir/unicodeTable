#' Function to print unicode table from a dataframe
#'
#' pass a dataframe as input the function will print to console a unicode table
#' @param data A data.frame or tibble to print
#' @param addRowNames Logical. Whether to add a 0-based index column.
#' @return prints the table to console.
#' @export
#' @examples
#' sep_line <- "──────────────────────────"
#' sep_score <- "─────────"
#' sep_total <- "──────────"
#'
#' data <- data.frame(
#'    `Metric Assessed` = c(
#'      "Statistical methodology", 
#'      "Replicability", 
#'      "Conclusions", 
#'      "Presentation", 
#'      "Citations",
#'      sep_line,          
#'      "Overall",
#'      sep_line    
#'    ),
#'    `Score` = c("17", "5", "5", "3", "2", sep_score, "32", sep_score),
#'    `Total Marks` = c("20", "5", "5", "5", "5", sep_total, "40", sep_total),
#'    check.names = FALSE
#' )
#' unicodeTable(data)
#'╭───┬────────────────────────────┬───────────┬─────────────╮ 
#'│   │ Metric Assessed            │ Score     │ Total Marks │ 
#'├───┼────────────────────────────┼───────────┼─────────────┤ 
#'│ 0 │ Statistical methodology    │ 17        │ 20          │ 
#'│ 1 │ Replicability              │ 5         │ 5           │ 
#'│ 2 │ Conclusions                │ 5         │ 5           │ 
#'│ 3 │ Presentation               │ 3         │ 5           │ 
#'│ 4 │ Citations                  │ 2         │ 5           │ 
#'│ 5 │────────────────────────────│───────────│─────────────│ 
#'│ 6 │ Overall                    │ 32        │ 40          │ 
#'│ 7 │────────────────────────────│───────────│─────────────│ 
#'╰───┴────────────────────────────┴───────────┴─────────────╯ 

unicodeTable <- function(data, addRowNames = TRUE) {
  
  df <- as.data.frame(data)
  # row names/indices
  if (addRowNames) {
    rowIndices <- 0:(nrow(df) - 1)
    # Bind it to the left
    df <- cbind("_IDX_" = as.character(rowIndices), df)
  }
  
  # Convert everything to character
  df[] <- lapply(df, function(x) {
    s <- as.character(x)
    s[is.na(s)] <- ""
    return(s)
  })
  # column names
  headers <- colnames(df)
  if (addRowNames) headers[1] <- " " 
  # --- width ---
  # compute display width
  get_width <- function(x) {
    w <- nchar(x, type = "width")
    w[is.na(w)] <- 0 
    return(w)
  }
  
  # column widths
  headerWidths <- sapply(headers, get_width)
  dataWidths <- sapply(df, function(x) max(get_width(x)))
  colWidths <- pmax(headerWidths, dataWidths) + 2
  
  # --- Unicode ---
  # Corners
  tl <- "\u256d" # ╭
  tr <- "\u256e" # ╮
  bl <- "\u2570" # ╰
  br <- "\u256f" # ╯
  # Junctions
  tm <- "\u252c" # ┬
  bm <- "\u2534" # ┴
  lm <- "\u251c" # ├
  rm <- "\u2524" # ┤
  cross <- "\u253c" # ┼
  # Lines
  h <- "\u2500" # ─
  v <- "\u2502" # │
  
  # --- create horizontal lines ---
  makeLine <- function(left, mid, right, widths) {
    segments <- sapply(widths, function(w) paste0(rep(h, w), collapse = ""))
    paste0(left, paste(segments, collapse = mid), right)
  }
  # --- format rows ---
  formatRow <- function(rowData, widths) {
    formattedCells <- mapply(function(val, width) {
      
      # chek if the cell content is purely separator
      if (grepl("^─+$", val)) {
        return(paste0(rep(h, width), collapse = ""))
      }
      valW <- get_width(val)
      
      # right padding needed
      # width = total desired width
      # 1 space on left + value width + right padding = width
      padRight <- width - 1 - valW
      if (padRight < 0) padRight <- 0
      # cell values
      paste0(" ", val, strrep(" ", padRight))
    }, rowData, widths)
    paste0(v, paste(formattedCells, collapse = v), v)
  }
  
  # --- PRINTING ---
  # top border
  cat(makeLine(tl, tm, tr, colWidths), "\n")
  # header
  cat(formatRow(headers, colWidths), "\n")
  # separator
  cat(makeLine(lm, cross, rm, colWidths), "\n")
  # data Rows
  for (i in 1:nrow(df)) {
    cat(formatRow(df[i, ], colWidths), "\n")}
  # bottom Border
  cat(makeLine(bl, bm, br, colWidths), "\n")
}