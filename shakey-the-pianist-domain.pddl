
        
(define (domain shakey)
  (:requirements :strips)

  (:predicates
    ;Define octaves (a piano is divided into octaves - they are like repeating units and are analogous to rooms)
    (octave ?octave)
    ;Octave can be active or inactive
    (active ?octave)
    ;gates between octaves that connect (seperate for chords and notes)
    (note-gate ?gate)
    (chord-gate ?gate)
    (connected-by ?octave1 ?octave2 ?gate)

    ;define a Shakey root
    (shakey ?shak)

    ;Shakey has fingers that can be full or empty
    (finger ?finger)
    (finger-free ?finger)

    ;Define a piano roll for Shakey to drop notes upon
    (piano ?piano)

    (note ?note)
    
    ;Define a floor (floor of octave room) for Shakey to pick notes up from in the inital state
    (at-floor ?note)
    
    ;Note can be in finger
    (in-finger ?note ?finger)
    
    ;Note can be at piano
    (at-piano ?note)
    
    ;Define chords
    (chord ?chord)

    ;Objects in octave
    (in ?any-objects ?octave)
  )

  ;Shakey can move through octaves that are connected by gates
  (:action shakey_changes_octave
    :parameters (?shak ?octave1 ?octave2 ?gate)
    :precondition (and
      (shakey ?shak)(in ?shak ?octave1)
      (octave ?octave1)(octave ?octave2)
      (connected-by ?octave1 ?octave2 ?gate)
    )
    :effect (and
      (in ?shak ?octave2)
      (not (in ?shak ?octave1) )
    )
  )
  ;Shakey can teleport to any octave (if uncommented)
  ;(:action shakey_teleports
    ;:parameters (?shak ?octave1 ?octave2)
    ;:precondition (and
     ;(shakey ?shak)(in ?shak ?octave1)
     ; (octave ?octave1)(octave ?octave2)
   ; )
    ;:effect (and
     ; (in ?shak ?octave2)
     ; (not (in ?shak ?octave1) )
    ;)
  ;)

  ;Shakey moves a chord through seperate chord gates (different gates seperate harmony and melody)
  (:action shakey_carries_chord
    :parameters (?shak ?chord ?octave1 ?octave2 ?chord-gate)
    :precondition (and
      (shakey ?shak)(in ?shak ?octave1)
      (chord ?chord)(in ?chord ?octave1)
      (octave ?octave1)(octave ?octave2)
      (chord-gate ?chord-gate)
      (connected-by ?octave1 ?octave2 ?chord-gate)
    )
    :effect (and
      (in ?chord ?octave2)
      (not (in ?chord ?octave1))
    )
  )

  ;Shakey activates an octave
  (:action shakey_activates_octave
    :parameters(?shak ?octave)
    :precondition(and
      (shakey ?shak)(in ?shak ?octave)
      ;(chord ?chord)(in ?chord ?octave)
      (octave ?octave)
      (not (active ?octave))
    )
    :effect (active ?octave)
  )
  ;Shakey deactivates an octave
  (:action shakey_deactivates_octave
    :parameters (?shak ?octave)
    :precondition (and
      (shakey ?shak)(in ?shak ?octave)
      ;(chord ?chord)(in ?chord ?octave)
      (octave ?octave)
      (active ?octave)
    )
    :effect (not (active ?octave) )
  )
  ;Shakey plays and takes the note (removing it from the floor)
  (:action shakey_plays_and_picks
    :parameters (?shak ?finger ?note ?octave)
    :precondition (and
      (shakey ?shak)(in ?shak ?octave)
      (finger ?finger) (finger-free ?finger)
      (note ?note)(in ?note ?octave)(at-floor ?note)
      (octave ?octave)(active ?octave)
    )
    :effect (and
      (not (finger-free ?finger))
      (not (in ?note ?octave))
      (not (at-floor ?note))
      (in ?note ?finger)
      (in-finger ?note ?finger)
    )
  )
    ;Shakey plays and leaves the note in its position
    (:action shakey_plays_and_leaves
    :parameters (?shak ?finger ?note ?octave)
    :precondition (and
      (shakey ?shak)(in ?shak ?octave)
      (finger ?finger) (finger-free ?finger)
      (note ?note)(in ?note ?octave)(at-floor ?note)
      (octave ?octave)(active ?octave)
    )
    :effect (and
      (not (finger-free ?finger))
      (in ?note ?finger)
      (in-finger ?note ?finger)
    )
  )
  ;Shakey plays and discards the note from his finger
  (:action shakey_plays_and_drops
    :parameters (?shak ?finger ?note ?piano ?octave)
    :precondition (and
      (shakey ?shak)(in ?shak ?octave)
      (finger ?finger)(not (finger-free ?finger))
      (note ?note)(in ?note ?finger)(in-finger ?note ?finger)
      (piano ?piano) (in ?piano ?octave)
      (octave ?octave)(active ?octave)
    )
    :effect (and
      (not(in ?note ?finger))
      (not(in-finger ?note ?finger))
      (in ?note ?octave)
      (in ?note ?piano)
      (finger-free ?finger)
      (at-piano ?note)
    )
  )
    ;Shakey plays and keeps the note in his finger
    (:action shakey_plays_and_keeps
    :parameters(?shak ?finger ?note ?piano ?octave)
    :precondition(and
      (shakey ?shak)(in ?shak ?octave)
      (finger ?finger)(not (finger-free ?finger))
      (note ?note)(in ?note ?finger)(in-finger ?note ?finger)
      (piano ?piano) (in ?piano ?octave)
      (octave ?octave)(active ?octave)
    )
    :effect (and
      (in ?note ?octave)
      (in ?note ?piano)
      (at-piano ?note)
    )
  )



)

