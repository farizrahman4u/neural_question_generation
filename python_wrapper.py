import os
def generate_questions(docs):
    if type(docs) is str:
        with open('input.txt', 'w') as f:
            f.write(docs)
	os.system('th run.lua')
	with open('output.txt', 'r') as f:
	    ans = f.read()[:-1]
	return ans
    else:
	with open('input.txt', 'w') as f:
	    f.write('\n'.join(docs))
	os.system('th run.lua')
	with open('output.txt', 'r') as f:
	    ans = [x[:-1] for x in f.readlines()]
	return ans

	   
