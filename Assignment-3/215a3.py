from time import time
import time
# A function to convert strings of literals into list of '0's and '1's
def lit_to_bool(s,n):
    lst=[1]*n
    i=-1
    for j in range(len(s)):
        if(s[j]=='\''):
            lst[i]=0
        else:
            i+=1
    return lst

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

    # If the term is empty that is all 'None's then we return 'None'
    if(term==''):
        return None

    return term

# The below function returns the max region corresponding to each term in func_TRUE
# It initially finds the maximum possible regions
# It does this by flipping bool values of literals and checking repeatedly
# It also optimizes by adding variables to final list if no change occurs as shown below
# It then maps the terms of func_TRUE to corresponding max regions
def comb_function_expansion(func_TRUE, func_DC):
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
    # demoterm =lit_to_bool("bc'",numofvar,literalslist)
    # print(demoterm)
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
                        # if (term == demoterm):
                        #     print(bool_to_lit(flipterm,literalslist))
                        #     demoterm = flipterm[:j] + [None] + flipterm[j+1:]

                        flipterm[j] = None

                        # If expanded region is not already there then add to newset
                        if (tuple(flipterm) not in newset):
                            newset.add(tuple(flipterm))

            # Observe that if there is no change to the term then it cannot be expanded
            # This allows us to optimize by directly adding it to maxlist
            if (termchange == 0):
                maxlist.append(term)

        termset = set()

        # Transfer newset into termset then reset it as mentioned above
        for i in newset:
            termset.add(i)
    return maxlist
def terminregcheck(term,reg):
        # loop over and check for any mismatch of bool values
        for i in range(len(reg)):
            if reg[i] != None:
                if term[i] != reg[i]:
                    return False
        return True
def regiongenerator(term,count,lst,DCset):
    if(count==0):
        if(tuple(term) not in DCset):
            lst.append(tuple(term))
    else:
        for i in range(len(term)):
            if(term[i]==None):
                regiongenerator(term[:i] + [0] + term[i+1:],count-1,lst,DCset)
                regiongenerator(term[:i] + [1] + term[i+1:],count-1,lst,DCset)
                break
    return lst

def opt_function_reduce(func_TRUE, func_DC):
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
    maxlist=comb_function_expansion(func_TRUE,func_DC)
    print(maxlist)
    countlist={}
    truelist=[]
    for i in func_TRUE:
        boolterm = lit_to_bool(i,numofvar)
        truelist.append(boolterm)
    DCset=set()
    for i in range(len(func_DC)):
        DCset.add(tuple(lit_to_bool(func_DC[i],numofvar)))
    for i in range(len(func_TRUE)):
        for j in range(len(maxlist)):
            if(terminregcheck(truelist[i],maxlist[j])):
                if(tuple(truelist[i]) in countlist):
                    countlist[tuple(truelist[i])]+=1
                else:
                    countlist[tuple(truelist[i])]=1
    essentialprimeimp=[]
    for i in range(len(maxlist)):
        term=maxlist[i]
        count=0
        for j in range(len(term)):
            if(term[j]==None):
                count+=1
        cells=[]
        cells=regiongenerator(maxlist[i],count,cells,DCset)
        print(cells)
        ind=0
        for j in range(len(cells)):
            if(countlist[cells[j]]==1):
                ind=1
                essentialprimeimp.append(bool_to_lit(maxlist[i],literalslist))
                break
        if(ind==0):
            for j in range(len(cells)):
                print("Deleted term:",bool_to_lit(cells[j],literalslist))

                countlist[cells[j]]-=1
    return essentialprimeimp
print(opt_function_reduce(["a'b'c'd'e'", "a'bc'd'e'", "abc'd'e'", "ab'c'd'e'", "abc'de'", "abcde'",
"a'bcde'", "a'bcd'e'", "abcd'e'", "a'bc'de", "abc'de", "abcde",
"a'bcde", "a'bcd'e", "abcd'e", "a'b'cd'e", "ab'cd'e"]
,[]))





