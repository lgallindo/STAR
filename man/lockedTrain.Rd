\name{lockedTrain}
\alias{lockedTrain}
\alias{plot.lockedTrain}
\alias{print.lockedTrain}
\title{ Construct and Plot Time-Dependent Cross-correlation Diagram }
\description{
  \code{lockedTrain} constructs and \code{plot.lockedTrain} (and
  \code{print.lockedTrain}) plot what van Stokkum et al (1986) call a time-dependent
  cross-correlation diagram. The lags between spikes of a test and a
  reference trains are plotted against the time of occurrence or the
  rank of the reference train spikes.
}
\usage{
lockedTrain(stRef, stTest, laglim, acquisitionWindow)
\method{plot}{lockedTrain}(x, keepTime = FALSE,
            stimTimeCourse = NULL, colStim = "grey80",
            xlim, pch, xlab, ylab, main, ...)
\method{print}{lockedTrain}(x,...)
}
\arguments{
  \item{stRef}{a \code{spikeTrain} or a \code{repeatedTrain} object.}
  \item{stTest}{a \code{spikeTrain} or a \code{repeatedTrain} object. If
  \code{missing(stTest)} is \code{TRUE} then \code{stRef} is used.}
  \item{x}{a \code{lockedTrain} object.}
  \item{laglim}{a two elements vector, the time window (in s) in which
  spikes in \code{stTest} around spikes in \code{stRef} are looked
  for. Default value are supplied when the argument is missing (+/- 3
  times the sd of the inter-spike intervals of \code{stRef}).}
  \item{acquisitionWindow}{a 2 elements vector specifying the begining and
    the end of the acquisition. If \code{missing} values are obtained
    using the \code{\link{floor}} of the smallest spike time and the
    \code{\link{ceiling}} of the largest one.}
  \item{keepTime}{a logical, if \code{TRUE} the ordinate is shown in s,
    otherwise (default) the spike index is shown.}
  \item{stimTimeCourse}{\code{NULL} (default) or a two elements vector
    specifying the time boundaries (in s) of a stimulus presentation.}
  \item{colStim}{the background color used for the stimulus.}
  \item{xlim}{a numeric (default value supplied). See \code{\link{plot}}.}
  \item{pch}{data symbol used for the spikes. See \code{\link{plot}}.}
  \item{xlab}{a character (default value supplied). See \code{\link{plot}}.}
  \item{ylab}{a character (default value supplied). See \code{\link{plot}}.}
  \item{main}{a character (default value supplied). See \code{\link{plot}}.}
  \item{\dots}{see \code{\link{plot}} or \code{\link{print}}.}
  
}
\details{
  The time-dependent cross-correlation diagram is described in van
  Stokkum et al (1986) and is also used by Brillinger (1992) Fig. 4. For
  each spike of \code{stRef} neighboring spikes of \code{stTest} are
  selected within a window defined by \code{laglim}. The lag between
  these \code{stTest} spikes and the ones of \code{stRef} are displayed
  (that is, the times of the \code{stRef} spikes is subtracted from the
  times of the neighboring spikes in \code{stTest}).

  If \code{repeatedTrain}s are given for \code{stRef} and \code{stTest} they must have
  the same number of components and are interpreted as coming from
  repetitions of the same stimulation, the spike times of the different
  trains of \code{stRef} are therefore reordered.

  The ordinate on the plot generated by \code{plot.lockedTrain} can be
  in term of real time or in term of \code{stRef}
  spike indexes.

  If \code{stimTimeCourse} is specified a box corresponding to the
  stimulus presentation is drawn in the background.
}
\value{
  \code{lockedTrain} returns a LIST of class \code{lockedTrain} with the
  following components:
  \item{shiftedT }{a list of lists. Each sublist has three components:
    \code{refTime}, the time of the reference spike; \code{repIdx}, the
    index of the stimulus repeat to which the reference spike belongs;
    \code{crossTime}, a vector of shifted times of the test
    neurons. These times are shifted because they are expressed with
    respect to the reference spike time.}
  \item{nbRefSpikes }{the total number of reference spikes used.}
  \item{nbTestSpikes }{the total number of test spikes occurring during
    the same observation period.}
  \item{laglim }{the value of \code{laglim} used.}
  \item{acquisitionWindow }{the value of the \code{acquisitionWindow} used.}
  \item{obsTime }{the total observation time used (in s).}
  \item{call }{the matched call.}

  \code{plot.lockedTrain} and \code{print.lockedTrain} are used for
  their side effects: a plot is generated. \code{print.lockedTrain}
  calls \code{plot.lockedTrain}.
}
\references{
  van Stokkum, I. H., Johannesma, P. I. and Eggermont, J. J. (1986)
  Representation of time-dependent correlation and recurrence time
  functions. A new method to analyse non-stationary point
  processes. \emph{Biol Cybern} \bold{55}: 17--24.

  Brillinger, David R. (1992) Nerve Cell Spike Train Data
  Analysis: A Progression of Technique. \emph{JASA} \bold{87}: 260--271.
}
\author{Christophe Pouzat \email{christophe.pouzat@gmail.com} }
\note{
  \code{plot.lockedTrain} displays essentially the "raw data" from which a
  cross-intensity histogram is built.
}
\seealso{
  \code{\link{as.spikeTrain}},
  \code{\link{as.repeatedTrain}},
  \code{\link{raster}}
}
\examples{
\dontrun{
## load spontaneous data of 4 putative projection neurons
## simultaneously recorded from the cockroach (Periplaneta
## americana) antennal lobe
data(CAL1S)
## convert data into spikeTrain objects
CAL1S <- lapply(CAL1S,as.spikeTrain)
## look at the individual trains
## first the "raw" data
CAL1S[["neuron 1"]]
## contruct the lockedTrain of each neuron with itself and look at
## it using a lag of +/- 25 ms
lockedTrain(CAL1S[["neuron 1"]],laglim=c(-1,1)*0.025)
lockedTrain(CAL1S[["neuron 2"]],laglim=c(-1,1)*0.025)
lockedTrain(CAL1S[["neuron 3"]],laglim=c(-1,1)*0.025)
lockedTrain(CAL1S[["neuron 4"]],laglim=c(-1,1)*0.025)

## Look at the Vanillin responses
## Get the data
data(CAL1V)
## convert them into repeatedTrain objects
## The stimulus command is on between 4.49 s and 4.99s
CAL1V <- lapply(CAL1V,as.repeatedTrain)
## look at the individual raster plots
plot(CAL1V[["neuron 1"]],stimTimeCourse=c(4.49,4.99),main="N1")
plot(CAL1V[["neuron 2"]],stimTimeCourse=c(4.49,4.99),main="N2")
plot(CAL1V[["neuron 3"]],stimTimeCourse=c(4.49,4.99),main="N3")
plot(CAL1V[["neuron 4"]],stimTimeCourse=c(4.49,4.99),main="N4")
## construct the locked train for the 3 pairs with neuron 1 as a
## reference
plot(lockedTrain(CAL1V[["neuron 1"]],CAL1V[["neuron 3"]],
     laglim=0.01*c(-1,1)),stimTimeCourse=c(4.49,4.99),pch="*")
plot(lockedTrain(CAL1V[["neuron 1"]],CAL1V[["neuron 2"]],
     laglim=0.01*c(-1,1)),stimTimeCourse=c(4.49,4.99),pch="*")
plot(lockedTrain(CAL1V[["neuron 1"]],CAL1V[["neuron 4"]],
     laglim=0.01*c(-1,1)),stimTimeCourse=c(4.49,4.99),pch="*")
}
}
\keyword{ts}
\keyword{survival}
