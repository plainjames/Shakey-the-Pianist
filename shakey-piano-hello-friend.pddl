        ;PROBLEM HELLO FRIEND
        ;
        (define (problem shakey-piano)
          (:domain shakey)
          (:objects
            
            ;We define 3 octaves and a buffer. The buffer represents a generic octave that is open to interpretation by the artist.
            octave0 octave1 buffer
            note-gate-0-1 note-gate-1-buffer note-gate-0-buffer
            chord-gate-0-1 chord-gate-1-buffer chord-gate-0-buffer
            piano0 piano1 pianobuffer
            
            shak mrRobot

            ;We define 5 fingers. Altering the number of fingers with tactical commenting results in further
            ;has cascading effects that can edit the route.
            finger1 finger2 finger3 finger4 finger5
            
            ;We enforce the music theory constraint of 'scale' by selecting the desired notes from a scale here.
            ;We define a group of notes. As an example I have used the C Major Pentatonic Scale across two octaves
            ;So every note apart from C, D, E, G, A has been commented out. Example: noteC denotes play on octave
            ; location (i.e. if on octave0, play C on octave0), noteC1 denotes play on octave location + 1.
            ; This combined system to associate a note with an octave allows for more variation (12 note transposition up )

            noteC
            ;CSharp
            noteD
            ;DSharp
            noteE
            ;noteF
            ;FSharp
            noteG
            ;GSharp
            noteA
            ;ASharp
            ;noteB
            
            noteC1
            ;CSharp
            noteD1
            ;DSharp
            noteE1
            ;noteF
            ;FSharp
            noteG1
            ;GSharp
            noteA1
            ;ASharp
            ;noteB


            chord
          )
          
          (:init
            ;Created two octave "rooms"and a buffer. Shakey carries notes between these rooms.
            ;The buffer is an arbitrary octave connected to octave0 and 1 and can be interpreted artistically.
            ;This can be easily extended to as many octaves as required, but the planner can already generate
            ;a very diverse array of piano paths so I have kept as simple as possible to ease understanding.
            (octave octave0) (octave octave1) (octave buffer)
            

            ;The connections between octaves in terms of note doors and chord doors. Comment out various connections to force different routes.
            (note-gate note-gate-0-1) (connected-by octave0 octave1 note-gate-0-1) (connected-by octave1 octave0 note-gate-0-1)
            (note-gate note-gate-1-buffer) (connected-by octave1 buffer note-gate-1-buffer) (connected-by buffer octave1 note-gate-1-buffer)
            ;(note-gate note-gate-0-buffer) (connected-by octave0 buffer note-gate-0-buffer) (connected-by buffer octave0 note-gate-0-buffer)
  
            (chord-gate chord-gate-0-1) (connected-by octave0 octave1 chord-gate-0-1) (connected-by octave1 octave0 chord-gate-0-1)
            (chord-gate chord-gate-1-buffer) (connected-by octave1 buffer chord-gate-1-buffer) (connected-by buffer octave1 chord-gate-1-buffer)
            ;(chord-gate chord-gate-0-buffer) (connected-by octave0 buffer chord-gate-0-buffer) (connected-by buffer octave0 chord-gate-0-buffer)
            ;If chords are needed (initial state)
            (chord chord) (in chord octave0)


            ;In each octave is a piano roll for Shakey to place notes upon
            (piano piano0) (in piano0 octave0) 
            (piano piano1) (in piano1 octave1)
            (piano pianobuffer) (in pianobuffer buffer)  
          
            ;Shakey starts in the buffer
            (shakey shak) (in shak buffer)
            (shakey mrRobot) (in mrRobot octave0)

            ;Shakey's fingers are empty and not holding notes (though this can be changed if specific starting notes are desired!)
            ;Fingers could correspond to fingering on piano keys with some constraints.
            (finger finger1) (finger-free finger1)
            (finger finger2) (finger-free finger2)
            (finger finger3) (finger-free finger3)
            (finger finger4) (finger-free finger4)
            (finger finger5) (finger-free finger5)


            ;The inital state of notes (objects) to be "picked up" and moved through octaves by Shakey the Pianist.
            ;State which note and it's starting position. Starting notes are 'at-floor' to colloquially imply they
            ;are to be picked up by Shakey. Here I have selected all notes to move from the buffer.
            ;(note noteC1) (at-floor noteC1) (in noteC1 buffer)
            (note noteC) (at-floor noteC) (in noteC buffer)
            (note noteC) (at-floor noteC) (in noteC buffer)
            (note noteE) (at-floor noteE) (in noteE buffer)
            (note noteA) (at-floor noteA) (in noteA buffer)
            (note noteD) (at-floor noteD) (in noteD buffer)
            (note noteG) (at-floor noteG) (in noteG buffer)
            (note noteG) (at-floor noteG) (in noteG buffer)
                        
          )

          (:goal
            (and
              ;End Shakey and mrRobot in Octave0
              (in shak octave0)
              (in mrRobot octave0)

              ;The desired end state for Shakey's fingers (fingers empty)
              (finger-free finger1)
              (finger-free finger2)
              (finger-free finger3)
              (finger-free finger4)
              (finger-free finger5)

              ;The desired goal state for notes.
             ;(at-piano noteC1) (in noteC1 octave1)
              (at-piano noteC) (in noteC octave0)
              (at-piano noteC) (in noteC octave0)
              (at-piano noteC) (in noteC octave1)
              (at-piano noteD) (in noteD octave0)
              (at-piano noteE) (in noteE octave1)
              (at-piano noteA) (in noteA octave1)
              (at-piano noteG) (in noteG octave1)


              ;If chords are desired (Shakey will move them through seperate doors allowing independence between melody and harmony)
              ;(in chord octave0)

              ;Turn the piano off when you're done with it!
              (not (active octave0))
              (not (active octave1))
              (not (active buffer))

            )
          )
        )
        