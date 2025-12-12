
////@function State Machine
////@description A struct which contains any number of states that are run through a single update() function.
function State_Machine() constructor{
	// We still want our state variable, as it will hold “the current state we are in”
	state = undefined;
	// But we also want a struct to store all of our states in
	states = {};

	
	
    ////@function update
	////@description Define a static method that we can pass the state struct to, and it does the updating.
	////@description If we need to change anything about how we assign a state in the future, then we only need to change this one bottleneck here, 
    ////@description We'll run this from the state machine, and it'll run the update function we stored in the state 
	////@description (whichever state is currently assigned to the state variable).
	static update = function() {
        // First we check to see if our state variable has been set to a struct printed out by
	// a State constructor, using is_instanceof(), so we can be sure it has the update function
        
		if (is_instanceof(state, State)) {
		// Then we make sure it's actually a function, since update starts off as undefined and 
		// perhaps we forgot to assign a function to it

 			if (is_method(state.update)) {
               	 	// And finally we run it.
                		state.update();
            		}
       	 }
   	 }
    ////@function add_state
	////@description appends state to states struct to be referenced later.
	static add_state = function(_state) {
        // As a safety measure, we check to see if a state with the same name already exists in our machine.
        // If we use the accessor to access a struct, and the key doesn't exist in the struct, it returns undefined
        // So we check if it's NOT undefined, which means that the key has already been set for the states struct
        // And therefore, we've already previously added a state with that name
        if (!is_undefined(states[$ _state.name])) {
            // We could exit the function here, or overwrite the state, or whatever we decided
            // was valid behaviour. I'll just throw a debug message to console to warn the programmer
            // And then simply overwrite it
            show_debug_message($"You already have a state named {_state.name} in the state machine!");
        }
        states[$ _state.name] = _state;

        // And we check to see if state has already been assigned to a state struct. If it hasn't, then this is the first state being added to the state machine, and we'll use it as the
        // "starting" state. As a side note, this is why setters are often a good idea, if we had just manually assigned state in a ton of places, and then decided to make a change like
        // this, we'd have a major refactor on our hands, but because we created a setter function early on, all we need to do is change that one function.
        if (is_undefined(state)) {
            state = _state;
        }
        return self;
    }

    ////@function change_state
	////@description updates the main state to whichever state is passed in.
	////@description If it doesn't exist, we warn the programmer that they are trying to change to a state that doesn't exist in the states struct.
    static change_state = function(_name) {
        // We run the same check as in Update to see if the state exists in the states struct, and
        // if it does, we simply set state to it.
        if (!is_undefined(states[$ _name])) {
            state = states[$ _name];
        }
        else {
            show_debug_message("Trying to change to a non-existent state!");
        }
    }

}

function State(new_name) constructor{
	// Update holds the code we want the 
	// State to run each step.
	name = new_name;
	update = undefined;

    // Another static method that allows us to provide a function the state will run every step as 
	// an argument and assign it to update.
	static set_update = function(_update_func) {
       	 update = _update_func;
        	return self;
   	 }
}