import requests
# res = requests.get('https://api.github.com')
# print(res.status_code) 
# print(res.headers) 
# print(res.json()['current_user_url'])
# res.json()-hiển thị dạng json
# res.text- hiển thị dạng text


#demo 2 => add params (query string)

#response=requests.get('https://api.github.com/search/repositories?q=requests+language:python')

# response = requests.get(
#     'https://api.github.com/search/repositories',
#     params={'q': 'requests+language:python'},
# )

# print('total_count',response.json()['total_count'])
#https://api.github.com/search/repositories


#demo 3: thay doi request header

# import requests

# response = requests.get(
#     'https://api.github.com/search/repositories',
#     params={'q': 'requests+language:python'},
#     headers={'Accept': 'application/vnd.github.v3.text-match+json',
	
# 	},
# )

# # View the new `text-matches` array which provides information
# # about your search term within the results
# json_response = response.json()
# repository = json_response['items'][0]
# print(f'Text matches: {repository["text_matches"]}')

#demo 4: POST data form

# response=requests.post('https://httpbin.org/post', data={'name':'tinh','age':18})
# print(response.text)

#demo 5: POST data json
response = requests.post('https://httpbin.org/post', json={'name':'tinh','age':18})
print(response.text)


