# Load values into registers and initialise result as 0 (a0 = 0)
addi a1, x0, -3
addi a2, x0, -2
addi a0, x0, 0

# Now we will take a2 value as counter (in t0) and check whether it is negative or not
add t0, x0, a2
blt t0, x0, negative_counter_to_positive
beq x0, x0, start_multiplication # if not negative simply jump to start multiplication label

# negative to positive in 2's complement (t0 = not(t0) + 1)
negative_counter_to_positive:
	not t0, t0 
    addi t0, t0, 1

# Like a do while (to add atleast once)
start_multiplication:
    add a0, a0, a1 # Store result in a0
    addi t0, t0, -1 # t0 = t0 - 1
    ble t0, x0, end_multiplication
    beq x0, x0, start_multiplication
    
end_multiplication:
	# Check the sign for the result (in t0 by xoring both a1 and a2)
    xor t0, a1, a2
    # Check if t0 is negative (sign bit still 1)
    blt t0, x0, should_be_negative_result
    beq x0, x0, should_be_positive_result
    
should_be_negative_result:
	# Convert sign if not negative, else skip to end
    bge a0, x0, sign_convert
    beq x0, x0, end
    
should_be_positive_result:
	# Convert sign if not positive, else skip to end
    blt a0, x0, sign_convert
    beq x0, x0, end
    
sign_convert:
	not a0, a0
    addi, a0, a0, 1
    
end:   
