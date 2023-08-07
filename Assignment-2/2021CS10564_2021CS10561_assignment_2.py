# A function to convert strings of literals into list of '0's and '1's
def lit_to_bool(literals,numofvar):
    boollist = [1]*numofvar
    varcount = -1

    # loop over string and get 0 or 1 by checking for ' after each literal
    for j in range(len(literals)):
        if (literals[j] == '\''):
            boollist[varcount] = 0
        else:
            varcount += 1
    return boollist

# A function to revert back the list into a string of literals
def bool_to_lit(boolterm,literals):
    term = ''
    length = len(literals)

    # loop over term to add literal to string
    for i in range(length):
        if (boolterm[i] != None):
            term = term + literals[i]

            if (boolterm[i] == 0):
                term = term + '\''

    # If the term is empty that is all 'None's then we return None
    if(term==''):
        return None

    return term

# The below function returns the max region corresponding to each term in func_TRUE
# It initially finds the maximum possible regions
# It does this by flipping bool values of literals and checking repeatedly
# It also optimizes by adding terms to final list if no expansion is possible as shown below
# It then maps the terms of func_TRUE to corresponding max regions
def comb_function_expansion(func_TRUE, func_DC):
    # This is for the case where there are no terms for which the function is 1
    if(func_TRUE==[]):
        return []

    firstterm = func_TRUE[0]
    numofvar = 0
    literalslist = []

    # loop to find the number of literals or variables
    for i in firstterm:
        if (i != '\''):
            numofvar += 1
            literalslist.append(i)

    termset = set()
    truetermlist = []

    # Adding true terms to above set and list
    for i in func_TRUE:
        boolterm = lit_to_bool(i,numofvar)
        termset.add(tuple(boolterm))
        truetermlist.append(boolterm)

    # Adding don't care terms to set
    for i in func_DC:
        termset.add(tuple(lit_to_bool(i,numofvar)))

    # This is for the demo
    demoterm = [0,0,1,1,1,1,1,0]

    maxlist = []
    change = 1

    # While loop to continue as long as some change occurs below
    while (change == 1):
        change = 0
        # Reset of newset as mentioned below
        newset = set()

        # Looping over the set containing all the terms
        for i in termset:
            term = list(i)
            termchange = 0

            # Looping over the bool values of literals of each term
            for j in range(numofvar):

                # If current literal is not None then we flip it
                if (term[j] != None):
                    flipterm = term[:j] + [1-term[j]] + term[j+1:]

                    # If flipped term is in set then the expanded region is LEGAL
                    if (tuple(flipterm) in termset):
                        termchange = 1
                        change = 1

                        # This is for the demo
                        if (term == demoterm):
                            print(bool_to_lit(flipterm,literalslist))
                            demoterm = flipterm[:j] + [None] + flipterm[j+1:]

                        flipterm[j] = None

                        # If expanded region is not already there then add to newset
                        newset.add(tuple(flipterm))

            # Observe that if there are no 1-variable flipped terms then the given term cannot be expanded
            # This allows us to optimize by directly adding it to maxlist
            if (termchange == 0):
                maxlist.append(term)

        termset = set()

        # Transfer newset into termset then reset it as mentioned above
        for i in newset:
            termset.add(i)

    for i in maxlist:
        print(bool_to_lit(i,literalslist))
    # Helper function to check if a term is in a given region
    def terminregcheck(term,reg):
        # loop over and check for any mismatch of bool values
        for i in range(numofvar):
            if reg[i] != None:
                if term[i] != reg[i]:
                    return False
        return True
            
    finallist = []

    # looping over true terms to get corresponding maximum region
    for inputterm in truetermlist:

        # looping over the maximum regions to check if term is in them
        for j in range(len(maxlist)-1,-1,-1):
            if terminregcheck(inputterm,maxlist[j]):
                # Convert the output in bool values to strings of literals
                finallist.append(bool_to_lit(maxlist[j],literalslist))
                break

    return finallist

print(comb_function_expansion(["a'b'cdefgh", "a'b'cdefgh'", "a'b'cdef'gh'", "a'b'cd'e'fgh", "a'bcd'ef'gh'", 
"a'bcdefgh'", "a'bc'd'e'fg'h", "abc'd'e'fg'h", "a'bc'd'efgh'", "abc'd'efgh'", 
"abc'def'g'h'", "abcdef'g'h'", "abcd'ef'g'h'", "abcd'ef'g'h", "ab'c'de'f'g'h'", 
"ab'c'd'e'f'g'h'"], ["a'bcd'efgh", "a'bcd'efgh'", "abcdef'g'h"]))