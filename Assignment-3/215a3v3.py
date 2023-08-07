class Term:
    def __init__(self,minterms,boollist):
        self.minterms = minterms
        self.boollist = boollist
        self.used = False

        self.minterms.sort()

    def __str__(self):
        alpha = ''
        for i in self.minterms:
            alpha += str(i) + ' '
        return alpha
    
    def __eq__(self,term):
        if term == None:
            if self.minterms:
                return False
            return True
        elif self.boollist == term.boollist and self.minterms == term.minterms:
            return True
    
    def use(self):
        self.used = True

def combine(term1,term2):

    if term1.boollist == term2.boollist:
        return None
    
    diff = 0
    result =[]

    for i in range(len(term1.boollist)):

        if term1.boollist[i] != term2.boollist[i]:
            diff += 1
            result.append(None)
        
        else:
            result.append(term1.boollist[i])
        
        if diff > 1:
            return None
    
    return Term(term1.minterms + term2.minterms,result)


def lit_to_bool(literals,numofvar):
    boollist = [1]*numofvar

    varcount = -1

    for j in range(len(literals)):
        if (literals[j] == '\''):
            boollist[varcount] = 0
        else:
            varcount += 1

    value = 0
    multiplier = 1
    for i in range(len(boollist)-1,-1,-1):
        value += boollist[i]*multiplier
        multiplier *= 2
        
    return Term([value],boollist)

# A function to revert back the list into a string of literals
def bool_to_lit(minterm,literals):
    term = ''
    length = len(literals)

    # loop over term to add literal to string
    for i in range(length):
        if (minterm.boollist[i] != None):
            term = term + literals[i]

            if (minterm.boollist[i] == 0):
                term = term + '\''

    # If the term is empty that is all 'None's then we return None
    if(term==''):
        return None

    return term

def initial_grouping(numofvar,truetermlist):

    groups = []
    for count in range(numofvar + 1):
        groups.append([])
    
    for trueterm in truetermlist:

        count = 0
        for i in trueterm.boollist:
            if i == 1:
                count += 1

        groups[count].append(trueterm)
    
    return groups




def opt_function_reduce(func_TRUE,func_DC):

    if func_TRUE == []:
        return []
    
    firstterm = func_TRUE[0]
    numofvar = 0
    variables = []

    for i in firstterm:
        if (i != '\''):
            numofvar += 1
            variables.append(i)

    truetermlist = []

    for i in func_TRUE:
        boolterm = lit_to_bool(i,numofvar)
        truetermlist.append(boolterm)

    for i in func_DC:
        boolterm = lit_to_bool(i,numofvar)
        truetermlist.append(boolterm)


    def get_prime_implicants(groups):

        if groups == None:
            groups = initial_grouping(numofvar,truetermlist)
        
        length = len(groups)
        if length == 1:
            return groups[0]
        
        else:
            unused = []
            new_groups = []

            for i in range(length-1):
                new_groups.append([])

            for j in range(length-1):
                group1 = groups[j]
                group2 = groups[j+1]

                for term1 in group1:
                    for term2 in group2:

                        term3 = combine(term1,term2)

                        if term3 != None:
                            term1.used = True
                            term2.used = True

                            if term3 not in new_groups[j]:
                                new_groups[j].append(term3)
                
            for group in groups:
                for term in group:
                    if not term.used and term not in unused:
                        unused.append(term)
                
            for term in get_prime_implicants(new_groups):
                if not term.used and term not in unused:
                    unused.append(term)
                
            return unused
    
    prime_imp=get_prime_implicants(initial_grouping(numofvar,truetermlist))
    for i in prime_imp:
        print(bool_to_lit(i,variables))
    print()
    dict={}
    for i in range(len(prime_imp)):
        minlist=prime_imp[i].minterms
        for j in minlist:
            if(j not in dict):
                dict[j]=[prime_imp[i]]
            else:
                dict[j].append(prime_imp[i])

    essprime=[]

    minnumberlist = []
    for i in dict:
        minnumberlist.append(i)
    
    for j in minnumberlist:
        if(j in dict and len(dict[j])==1):
            poppedterm = dict.pop(j)[0]
            for minterm in poppedterm.minterms:
                if(minterm in dict):
                    dict.pop(minterm)
            if poppedterm not in essprime:
                essprime.append(poppedterm)
    
    print(essprime)
    for i in dict:
        print(i)
        for j in dict[i]:
            print(bool_to_lit(j,variables))
        print()
    
    def findVariables(term,literalslist): # Function to find variables in a meanterm. For example, the minterm --01 has C' and D as variables
        var_list = []
        for i in range(len(term.boollist)):
            if term.boollist[i] == 0:
                var_list.append(literalslist[i]+"'")
            elif term.boollist[i] == 1:
                var_list.append(literalslist[i])
        return var_list
    
    def mul(x,y): # Multiply 2 minterms
        res = []
        for i in x:
            if i+"'" in y or (len(i)==2 and i[0] in y):
                return []
            else:
                res.append(i)
        for i in y:
            if i not in res:
                res.append(i)
        return res

    def multiply(x,y): # Multiply 2 expressions
        res = []
        for i in x:
            for j in y:
                tmp = mul(i,j)
                res.append(tmp) if len(tmp) != 0 else None
        return res


    if(len(dict)==0):
        return essprime

    P = [[findVariables(j,variables) for j in dict[i]] for i in dict]

    print(P)

    while len(P) > 1: # Keep multiplying until we get the SOP form of P
        P[0] = multiply(P[0],P[1])
        P.pop(1)

    final_result = [min(P[0],key=len)] # Choosing the term with minimum variables from P

    final_result.extend(findVariables(i,variables) for i in essprime)

    return final_result


print(opt_function_reduce(["a'b'c'd'","a'b'c'd","a'b'cd'","a'bc'd","a'bcd","a'bcd'","abc'd'","abc'd","abcd","ab'c'd'","ab'cd","ab'cd'"],[]))



        

    


