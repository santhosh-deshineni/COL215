# The below function takes in two arguments namely kmap_function and term to give a 3-tuple as the return value.
# The underlying logic of the function is to mainly find the possible rows and columns.
# These rows and columns are then parsed to find the top-left, bottom-right and legality truth value.
# Note that all the logic of the function is to solve a 4 variable kmap.
# It then generalizes to 2 and 3 variable inputs as well by converting them into 4 variable inputs as explained below.

def is_legal_region(kmap_function, term):
    # length of term
    numofvar = len(term) 

    # Note that a 3 variable input to the function is converted into a 4 variable input.
    # A zero is appended to the term and then swapped with the input for c to create the converted input.
    # The value of c being fixed to zero means that the 4*4 kmap formed is converted back to a 2*4 kmap.
    # The value of d represents the c of original input.
    # Refer to the writeup for a more clear justification.
    if numofvar == 3:
        term.append(0)
        term[2],term[3] = term[3],term[2]
    # Note that a 2 variable input is also converted to a 4 variable input.
    # The converted input is created by inserting zeroes at the place of a and c.
    # The value of a and c being fixed to zero converts the 4*4 kmap to a 2*2 kmap.
    # Note that the values of the actual a and c are represented by b and d in this new kmap.
    # Refer to the writeup for a more clear justification.
    elif numofvar == 2:
        term.insert(0,0)
        term.insert(2,0)

    # A dictionary for mapping of variables a and c to columns and rows respectively
    acdict = {0:(0,1),1:(2,3),None:(0,1,2,3)}
    # A dictionary for mapping of variables b and d to columns and rows respectively
    bddict = {0:(0,3),1:(1,2),None:(0,1,2,3)}

    # The sorted list of possible columns is found by taking the intersection of possible columns for a and b.
    columnlist = sorted(list(set(acdict[term[0]]) & set(bddict[term[1]])))
    # The sorted list of possible rows is found by taking the intersection of possible rows for c and d.
    rowlist = sorted(list(set(acdict[term[2]]) & set(bddict[term[3]])))

    # These are the general values of top-left and bottom-right not taking into account border conditions
    topleft = [rowlist[0],columnlist[0]]
    bottomright = [rowlist[-1],columnlist[-1]]

    # For a 3 variable input, correction is required in the case where b is zero.
    # This is because the term extends over the column border of the kmap.
    if numofvar == 3:
        if term[1] == 0:
            topleft[1] = columnlist[-1]
            bottomright[1] = columnlist[0]
    
    # For a 4 variable input, correction is required when b or d is zero.
    # This is because the term extends over the column and row border respectively.
    if numofvar == 4:
        if term[1] == 0:
            topleft[1] = columnlist[-1]
            bottomright[1] = columnlist[0]
        if term[3] == 0:
            topleft[0] = rowlist[-1]
            bottomright[0] = rowlist[0]

    # This function checks whether the region corresponding to the term is legal or not.
    # If a cell with value 0 exists then it returns false since LEGAL region must contain only 1 and 'x'.
    # If the region does not contain a 0 then it returns true.
    def legal_check():
        for i in rowlist:
            for j in columnlist:
                if kmap_function[i][j] == 0:
                    return False
        return True
    
    return (tuple(topleft),tuple(bottomright),legal_check())

