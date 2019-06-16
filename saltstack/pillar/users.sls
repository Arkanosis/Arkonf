# TODO change uid of arkanosis from 1000 to 1301 where applicable (1000 is for Debian / Ubuntu)
# TODO change gid of famille from 1100 to 1004 where applicable
# TODO change login of sshbridge to rssht-user where applicable (and update rssht installs)
# TODO change login of oodna to asdp where applicable
# TODO change login of snad to Sandrine where applicable
# TODO change uid of Sandrine from 1101 to 1001 where applicable
# TODO names in UTF-8
# TODO user emails
# TODO user pictures (KDM)
# TODO guest account with no password and home on tmpfs

users:
  - login: arkanosis
#    fullname: 'Jérémie Roquet'
    email: jroquet@arkanosis.net
    id: 1301
    groups:
      - dialout # access to /dev/tty* for (g|w)ammu
      - docker
      - famille
      - amis
    sudo: True
    ssh: True
    linger: True
    arkonf: True
    authorized_keys: |
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDy7TxBlLWSZCWw8VlMyNnRAR071V0A1qv8qBe1jEosIK/yBP+paH0JJlAmNeE0XhYW3yLk5hkVqr5OB2nLIgFEKIiLMUIEqvV/MGVG/P77iuQIQqM+bRsU/zxtmY5z/U5WxPEQJWoLWGqx9I2xC7jIGjPdtaTdHIxPnfRigBvA4OkZ7nI2dm/y2yZKs2HbXiR4q0UujTw6Cw47wVn+UbfXoBdnbfvOcunljoHf+Th8EhL0U7cOr5FCNdthyrkxSl9D33coX1KDwS8Q+9cCx054mIDHbzVNdLCS7a5FDAH7P6eAdUnuPrbVhoX667OWz+XnNB/7d0GyIc663k12l7RUnGJWNT8ZuzvLkVj5eJ9hbqqphEtdrMKX5G5qhuDlPevc7VP3a3+alHCZZP8f3x0PL3smSU8nUHYj36v1HqzV/bGNa6fDiFmcXewvmcTIkiFO3pQsFNYs/HC6UmW7QpV4YbbURwnQRSoPgBy96pfglNzSw9ufmRiJUCOVuwM6N2IyhwJvhv60+/Vo8eZ8N6aWN/1E/FpJQ2AhLNbyMg4lrNyUER3J2sPakOvSxxq94sSf4Vp+jAPPEuIiPfpSh4ehVSNzbtATt5y+sY3CNy01DANhx1GBGAU7QzjkAvO7fXg2YHzsOw+s2A0igbNcmVmKmSWSRe6NEEkTbtCsQZp1dw== arkanosis@taz
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtZyNQkjHBS7Xg+ScEQpM0O9CJS4fG+/hlDSUAwewhsA9KhrhPDPnIYNithvQGXk+viX2UcOa3mZpir4/dx/pK/gTc7eZI4n3lC3ilZKqLiE9mhv1ZwU3IFfU0rN/FrKBsCqtHyV0JitRjF4S95hC4MeQGNWJbPqn7qyXimC6O7XIT8/6gO4tVyqw03xZ5i2IfU/RL8FnLA+RyfB4QUo3P5oexyhz1ElZHv7a5oRyiVFSvBFAiXY7XeYApFbk5/qqOeorwLILOWgpMvpKmsHXI3PaLTj+XRh2BeLWBHYRemuSIbqHc+zX2J8TGe2sEPEnLxn9KfynRVAURCBciQaVH5S7Z+UkYlj1UM93QlpGJdS7EGPFpAhIIOJRrTtktippyKNGx9Z7sfbZ5aIstrKuK5XUxN90xaZIx7mG9G0d5XAJi9skaBGu3xIkDbLMYij4Jf4ihyI1c8hmE8pv4xWcIv20ge15HCq/bGg0kA8HNRLUYQ5V7D85EZ04vAH4Z0dArYeDv1bfoT0arW+kafw2qxQK5ccnfsypQLimf0/M17yV0vDVjj3HpkKxFnxBndbVB/mZUvgVHOFG/kiQernljmIZm2SqDA5HaDmDbVwK81hhCWRbrL9xa3al193QMgWGfLUZKw4knPZriwn2mIqMsq9YQV/ZfLhxm3+MaYpKc+Q== arkanosis@marvin
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDUT18HfYMsFDBzlU4FtG3aetVZIg7DwGQLPzHfRv0pI2B/S8O0Saqfb19Nu/zOLtKCdD2+g5ZugKG38WXHRLjGoullmRcaZFDWfCQAdsJAS7hCfgp44/kmOiqc6TzZxQTmU0l9Z7qxkt8kYHaCqc9FKV179TQzHN7csYMgZGGLhIlYX2OrjEUqjNzHxW7agnEfSyw3ZQI3WzuKnPv7BdQ0EiEFz/+A7Dnn0jS4BrX8XVqDgBhzlY5uO+Vp0ZKQmgKfTbhO0yGoolWVhJJNU2erEii+7Cik/PDqpltAGH77SC5DM3RtoabB5YX93cCAvHtpqdKelmQteFMzFDGOEr6smD9MI2X5fEu09VFb8iw9UflFpjH4/iAGvBcwl1FUxXEhg6wyQvozemn6Bg/YnLlN4a0NZqA+VqkDb27w9e6D+CxHAWkTTmvSM3she3TBeKhLxB2aJM4Az9vrbfnecBYF19ahzzdD9TqoPwnfmH13Rr4iPlad4MPCGETpqHfF0pMHJ8OqzdE9RQ8gU5KEiOb/hYJQ3420hm6YWMtfD2WdqbUYaJppYdho9k48NdlIVqNexEwpBqNAUOmG5ik36+cdqopNXn+TdAju0TvaNV4e6BVA767RTCf6QxlH0kkmYx5hDH9LLKaC5W3rFJZtY8DKIMFZDf1jTZWmXlR3tGf2nw== arkanosis@gossamer
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+2JUMpZWHuh9xQIdCHTiOt9DKMssf2hOxVNkj2Xer/YGZBRjUFtm2M7PbbAv1MOJ5hD6jnq/jY6A6Ng7vWyscVF6OwZunQzK+k6S3iVCYxmve5N/sJt4SIirg/XNcZUPGSOn7FkbcfCRqtbekSHaUKvOubCFJgS0iGTgRrYzBhT3hb88DLhvBUrWDAYMcA7XlQl/nwGLmZScfO9uuLdTsVvDNr7cO1xcJTCI0yljh1bBfIA7YVrUknxfI4QkJHwkonH4VeSqoOo6riag2ntZUpMUZbUc4uLS1QYD6jATB4pOEh6g4PxjdJUzGjZuhQHmC9rZq6SCE/wpPHLljrLOdjLarTjh0/0t6xELhtkb0EHvXCAEp6J5TwPD8JvJKtChN4OLh2UqN0xLwDKSdcEQqod4+EQjaV604gQFRusX1pOGy40uKWeA+A8mC6GsWyizQ73hjeaXQnWo/TPAwWP/yHTerxA1ld9FSjn/EYL/FhjCChUcGqcRL8bsTimfPSJZGHeH5gLHqpA4/yMilZngGXOvBW7ALuvf+u0tpZAEGFfQ/4LeuSLndcg6R835kgxK+w9yC34L29MV/+n1edwwHntaCz8Ww8cZBTxiG0CYXwyv6yv9uwYCE4fIUoVrPMBrB2KdtjY+wY2YWBl/3Q7TDA1HnDG3M4o3SXcaigAgQdw== arkanosis@Edelweiss
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDLGBq47yigpl706RU/xQ9VKcTh41h1lTJBKRQxUw/QJ4WpQy0NKzHAKfqQHWx0sOa5x3E6JfK9FBxw3dFN6HerUSenzZcy+m47lCv/iFvy5CIVIgqK1eoqPikjv6eJrefY4iHLCMU5hCWdjPkjWiBo7kab4Ez2D0cfz/6hIeiqHskvBadEP4w+uGk6A/XKm5bmSkjG7FOobzW5Sw44Vj6xVYFlj8pZ/MMc5Ff81tzjVhqWOp7SiXE4bBfabq1JxnSXu7ckqf46HDw9oQ8SiY8LcIg1lPMP70VEJWaaA57jXjWnTSVWqWIiueDIIgHup7yt5RCLwsbCFB6Rq24cQuDfT2I3WMgAWPLAycLBkqgB2wPwGJsBwRM/8ODxN96Kpbuppwt1BaohjgVRmcNziFaD7wzh485vjqdkg6hi6hqDtwFui7PnMGcTBsKZGY6ba5TmFkesXquIOOlptEHLT2pL5+6O23IejyvxnMOCl4pLUWs01rgDUyg2xphFjgiQacGViSlavumIKY1p2byrdAtSRB2gpZiE0k1MJ2TwtOqS10VVOQGkF1XGV0XTtVfBti64badOOcLu8iPR9N8C0lch6jd1U+SjpBO6KM0vBl14cBB7U085FuEQlJ2NJjn3TsrunK8qICQ9DTY6tFVEfu1oxZ8Qar+tx1ALhDTCKUdeZw== arkanosis@Cyclamen
      ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAxgLP5lZxoztLhcq4tX+/+UHES3Sf6Gf0t+TQ8NP8l5fKvbinUta8Ffa1wvo25hhkRoBthMKtQm9vPYbaywnt7/zJttvexGy1ZDx1JZHL0wdp/E9rG3tluBhMITv9EYTOIcLix2smPTqxyRyQXjgf5xE/I5dnCHDjBRfoShCtPKWRwVCU7mQli7sij6sLzQzqhPYMGD3ldTZdIgxMHUQXhD0RJQgD6EhrmJlOGNZ3D7jXFyU+g1VjFwdajB2+MMtexvlfSZHGVgO5nhiOZ1bZEka/wiAhzQ5o805OKv3L5tuG+YjbkaDpbXfEoBg2LXrsosyo9g2aScnHQa5uCBh1ow== jroquet@Exalead
  - login: Sandrine
    fullname: 'Sandrine Roquet'
    id: 1001
    groups:
      - famille
  - login: Daniel
    fullname: 'Daniel Roquet'
    id: 1002
    groups:
      - famille
    linger: True
  - login: Annette
    fullname: 'Annette Menguy'
    id: 1003
    groups:
      - famille
  - login: Simonne
    fullname: 'Simonne Roquet'
    id: 1005
    groups:
      - famille
    linger: True
  - login: Marie-Christine
#    fullname: 'Marie-Christine Tréfond'
    id: 1006
    groups:
      - famille
  - login: asdp
#    fullname: 'Anne-Sophie Denommé-Pichon'
    id: 1201
    groups:
      - famille
      - amis
    arkonf: True
    authorized_keys: |
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDT2DnTMUJzr/mxFWm2tQ2PPDu16FO8oTiFDlw/Iq7kBYxFJWnBTHpxUWZiBzWZi9qZPFlVrz3v84UGEUcuFIy7Es2XTtFGI11dFJTkSngU/dCttrM0CmVPqqJ8t/4eFB+ZrSS5vBOAagRX2Ot+nhbh0+csi9Ejp7xpWLvCOxZ1NQShAY7TRQs0hBHwjOJ6389IUCgW8NZqoAsRF4Vs1B9ac3jBdb1YOZKK8LPHrSd7/UsUoQzDulQ1/iwfSKLn3QaqOFPbGwUNtpsbH/aWdOAW1li8Sd7mQN+U88gB0bs67ysg1a0pUSI6WrNAQIafyvWfhP1I3dQMY1MpKVyLZeNIzl2wLMKtjHzwd6KoIEkcdLzic6AzywdLHwTADHA8+iSqUosGT4gC5WCb3pUOSpVp5x5pbrOhRkN5E0q3jxPrLtg+Vrp5LXBTw+e6d0NLaBSqtqnNMMib4bws9RAFuRHK3MWSpaJo4BT/w2qT28f8CxI0E+IEmYu8lGOSWPDtpqXLzMwRhUge85zN0mrJbYbxsp8MywCQazJVsdWHL+w3FZY5RwiR3LfDZ62z0fTmB73sT2HuFjbAz0WhGc7sP0sDz9v/dP0MSpWF+ziv2f3fIxEamVimBgpv8mMZFp+DOyd1OtiUwbSONt7fe82rbrCVChV5R9ifdym92IK4wb0L9w== asdp@asdp-UX305CA
  - login: nonfreegaming
    id: 1901
  - login: sftp-denomme-fr
    id: 1211
    sftp: True
    authorized_keys: |
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDT2DnTMUJzr/mxFWm2tQ2PPDu16FO8oTiFDlw/Iq7kBYxFJWnBTHpxUWZiBzWZi9qZPFlVrz3v84UGEUcuFIy7Es2XTtFGI11dFJTkSngU/dCttrM0CmVPqqJ8t/4eFB+ZrSS5vBOAagRX2Ot+nhbh0+csi9Ejp7xpWLvCOxZ1NQShAY7TRQs0hBHwjOJ6389IUCgW8NZqoAsRF4Vs1B9ac3jBdb1YOZKK8LPHrSd7/UsUoQzDulQ1/iwfSKLn3QaqOFPbGwUNtpsbH/aWdOAW1li8Sd7mQN+U88gB0bs67ysg1a0pUSI6WrNAQIafyvWfhP1I3dQMY1MpKVyLZeNIzl2wLMKtjHzwd6KoIEkcdLzic6AzywdLHwTADHA8+iSqUosGT4gC5WCb3pUOSpVp5x5pbrOhRkN5E0q3jxPrLtg+Vrp5LXBTw+e6d0NLaBSqtqnNMMib4bws9RAFuRHK3MWSpaJo4BT/w2qT28f8CxI0E+IEmYu8lGOSWPDtpqXLzMwRhUge85zN0mrJbYbxsp8MywCQazJVsdWHL+w3FZY5RwiR3LfDZ62z0fTmB73sT2HuFjbAz0WhGc7sP0sDz9v/dP0MSpWF+ziv2f3fIxEamVimBgpv8mMZFp+DOyd1OtiUwbSONt7fe82rbrCVChV5R9ifdym92IK4wb0L9w== asdp@asdp-UX305CA
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7iNhmK8tMInKBafAYk3KBUZz7egXWAAPq02w/5ukqbzrRaN4zYoWDl60BRaYHP5K6ivx2mFbvLJzEUFijX8mOsReAxjS8TeO/Pzr7p/ZmKE0Vq3JQJocOZGfWg9yn9WZC8O+wfiFoHGrRY+kjuwsflnNZIC/sJNCiH7MONhEFAVhnSR3cUME8+qIuIejMbiNRaLHjrXwBCahYGsd7ujXS7J2WYG4xk11KqEjeZrlYA3YlMpao31v+1cyys64duwlGCzHc0sNehqiq3E8QQolGpYU9bXLvMxXx9MsRyJQ/RP/RGIE9fDjoCMlF72hk7yg6H2dtEruKE0vu9zx/DoIJiT5Pq3xjSVHdUJaWFvg1EMISENvRoMb+XsJ3D9dtl5PkSQoMxk6QHiwFF9Irgw49+Ylh5PQNrYrCDCpD9iK+5BM1UbnpARvrcbxccOL5b/U4H7JcMGAs5OU1WriUDulPc9wt7DSr5oiL0nlF4UfpiBDNCXkfHisdobKPrkzKL/Xros2QKpzzs48bU3oh1iJQFiXSPnCLujYAL8Vkt7uVrSBxYfhcUq/bF1llj1CaqLiMxGlHEtkSKRV9o/afcgkyW5MN4D8uBK+xGwsK3h0/v+f1Y08WhGrTyT5pWL9Vo+hHPKwKUDajQ6US/GtUh025PHWqpvphf0FKvrmLDr6mrw== arkanosis_sftp@marvin
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDuu5Cz6ww5srWFCSQmcKSWLR4G5G1N5sxrpl3tWPPJ5lj7CffBeDsacqt+kFk8fsnsfZ1NT+GOpXGyIOXgAvIIz5cd4Z5PKBL3Y24AqLWGiXAxayPPEzJ1rBDwR8hpSlVw+EepznN/d4zqoAR8sGT0zbcU1Sud8kpV03wxFcJsAkfaC0bnP78RCouEmk0p1Q4Nm9sQtV1Q3xsIsj+TFx6qKIowIf5TF1XnNkQ86vaNoko5VAB5VWFZtWvlrA3dKZO4O6iKJREY8sVBBg3aWIMzmsZTsf0fS9p1OPExHBfPM0cdfCPQPQ8/Sv+ruJHyhW/H031IurERz8V7s85yaiVln4grVZl2lzOs6+MGnm4eLfjnDYVrUf0HZe3bdbr2g64fdbf4UFrSYe2oEMoPufEX9DXt9C+gAfSrVLhySfLORLTV7Whnv3bqY6QZMmV1atXKPISU4sZvfLvd4HNGAQhFzHfh3PFz9ea8xnnThrW3FbCQ76gSYSpscPsxPuxvfNPif6ha9CzIMyf6yDoZPEWUGMhCJuKfOhB7RJtG/k7yN/YESRvN45ZE/6wWNWngTwdoK1N0XKxiOB8l3Ovr6J1hd7h0OeKIL6wzS610E/9oBm0nmPuv0alBv/B8INaGjcQF1b2svKtl3gEXM7/Fp8mc2U28ow26maiqizinfWUxew== asdp@G0ARO11
  - login: sftp-regovar-org
    id: 1212
    sftp: True
    authorized_keys: |
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDT2DnTMUJzr/mxFWm2tQ2PPDu16FO8oTiFDlw/Iq7kBYxFJWnBTHpxUWZiBzWZi9qZPFlVrz3v84UGEUcuFIy7Es2XTtFGI11dFJTkSngU/dCttrM0CmVPqqJ8t/4eFB+ZrSS5vBOAagRX2Ot+nhbh0+csi9Ejp7xpWLvCOxZ1NQShAY7TRQs0hBHwjOJ6389IUCgW8NZqoAsRF4Vs1B9ac3jBdb1YOZKK8LPHrSd7/UsUoQzDulQ1/iwfSKLn3QaqOFPbGwUNtpsbH/aWdOAW1li8Sd7mQN+U88gB0bs67ysg1a0pUSI6WrNAQIafyvWfhP1I3dQMY1MpKVyLZeNIzl2wLMKtjHzwd6KoIEkcdLzic6AzywdLHwTADHA8+iSqUosGT4gC5WCb3pUOSpVp5x5pbrOhRkN5E0q3jxPrLtg+Vrp5LXBTw+e6d0NLaBSqtqnNMMib4bws9RAFuRHK3MWSpaJo4BT/w2qT28f8CxI0E+IEmYu8lGOSWPDtpqXLzMwRhUge85zN0mrJbYbxsp8MywCQazJVsdWHL+w3FZY5RwiR3LfDZ62z0fTmB73sT2HuFjbAz0WhGc7sP0sDz9v/dP0MSpWF+ziv2f3fIxEamVimBgpv8mMZFp+DOyd1OtiUwbSONt7fe82rbrCVChV5R9ifdym92IK4wb0L9w== asdp@asdp-UX305CA
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC7iNhmK8tMInKBafAYk3KBUZz7egXWAAPq02w/5ukqbzrRaN4zYoWDl60BRaYHP5K6ivx2mFbvLJzEUFijX8mOsReAxjS8TeO/Pzr7p/ZmKE0Vq3JQJocOZGfWg9yn9WZC8O+wfiFoHGrRY+kjuwsflnNZIC/sJNCiH7MONhEFAVhnSR3cUME8+qIuIejMbiNRaLHjrXwBCahYGsd7ujXS7J2WYG4xk11KqEjeZrlYA3YlMpao31v+1cyys64duwlGCzHc0sNehqiq3E8QQolGpYU9bXLvMxXx9MsRyJQ/RP/RGIE9fDjoCMlF72hk7yg6H2dtEruKE0vu9zx/DoIJiT5Pq3xjSVHdUJaWFvg1EMISENvRoMb+XsJ3D9dtl5PkSQoMxk6QHiwFF9Irgw49+Ylh5PQNrYrCDCpD9iK+5BM1UbnpARvrcbxccOL5b/U4H7JcMGAs5OU1WriUDulPc9wt7DSr5oiL0nlF4UfpiBDNCXkfHisdobKPrkzKL/Xros2QKpzzs48bU3oh1iJQFiXSPnCLujYAL8Vkt7uVrSBxYfhcUq/bF1llj1CaqLiMxGlHEtkSKRV9o/afcgkyW5MN4D8uBK+xGwsK3h0/v+f1Y08WhGrTyT5pWL9Vo+hHPKwKUDajQ6US/GtUh025PHWqpvphf0FKvrmLDr6mrw== arkanosis_sftp@marvin
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDuu5Cz6ww5srWFCSQmcKSWLR4G5G1N5sxrpl3tWPPJ5lj7CffBeDsacqt+kFk8fsnsfZ1NT+GOpXGyIOXgAvIIz5cd4Z5PKBL3Y24AqLWGiXAxayPPEzJ1rBDwR8hpSlVw+EepznN/d4zqoAR8sGT0zbcU1Sud8kpV03wxFcJsAkfaC0bnP78RCouEmk0p1Q4Nm9sQtV1Q3xsIsj+TFx6qKIowIf5TF1XnNkQ86vaNoko5VAB5VWFZtWvlrA3dKZO4O6iKJREY8sVBBg3aWIMzmsZTsf0fS9p1OPExHBfPM0cdfCPQPQ8/Sv+ruJHyhW/H031IurERz8V7s85yaiVln4grVZl2lzOs6+MGnm4eLfjnDYVrUf0HZe3bdbr2g64fdbf4UFrSYe2oEMoPufEX9DXt9C+gAfSrVLhySfLORLTV7Whnv3bqY6QZMmV1atXKPISU4sZvfLvd4HNGAQhFzHfh3PFz9ea8xnnThrW3FbCQ76gSYSpscPsxPuxvfNPif6ha9CzIMyf6yDoZPEWUGMhCJuKfOhB7RJtG/k7yN/YESRvN45ZE/6wWNWngTwdoK1N0XKxiOB8l3Ovr6J1hd7h0OeKIL6wzS610E/9oBm0nmPuv0alBv/B8INaGjcQF1b2svKtl3gEXM7/Fp8mc2U28ow26maiqizinfWUxew== asdp@G0ARO11
  - login: rssht-user
    id: 900
    system: True
    ssh: True
    shell: /bin/false
    authorized_keys: |
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDxfr94sLaZ/RdSh6rJntGSjjAT2ch9idfoRpg/A5VZugU4RklB6usEeYCp3vUW+87kUgmfko0lSqaapDAXSEy9Iv7UF6TvIVG7FqGefIx1oIcCYyvK9zYTj4aDm9RyVG9WDBODsOIrNOWiiARsN+ppRHqOUfhgP0+kBAFIBZyHiRw98fN6gFjqssQug8hU5Gjuer3NJNKZQe9nFtE6hBVj8U0Ad/du8WsmMr2rB+4DA8Ls5sG11CSWbNIoFRbWylVXgsnkXVpqe+TgleYs2pAclp3LHPO3BQhyMthm2nV3S7w6iY3CczkuNyBztG4nfuzJRP0HsYR3rKHRahoTGSsfLtc0rFKWCFQvFW5uBJjL0Fa86aewPQoy1iOSIxz6/6J3gqB4/M772tlIszEyEei6AsoP/q4BhBtesURqTKka7VeTUrnt1D1Pqll7Rsi9ZQPehihvHXYjcYTZhXgQWyJTI7YHh0/6St8vWSOUvd69hGXIHdZwpyn/xC6QY6rF9u9WflFEnu7BkFOTAw7gx6lMzXc+M0GzvObNYpI/zGnqWjSslP8tAOFyD6vnAq6FsUK9YkrTZ26f2vYXrfcFpjMXEq0V8phklB4CAmt+ZsyLm9nnm0RcloF1mtkE93NKqSwXa+HfTDiKHeyRP9u/iH30DUbq3w5vuNNYwvvGHVJlJQ== jroquet_rssht@Exalead
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKRafi9AnUwJk0o7KBUUZT2Q5UHViIN9ZEJlzk8UzPvF5VkGxgp3l4Zndfy3g4qwXWbmI1JlYmiZsYrgHUSzpSfsu51Uu1zLr6HcPQUH5IPbhd5NE4m9QVwBnJNzFgeDFP89Ytkp5A+Yfjb59P8YKdckBrNEHeINzWAHcwa8SkQO1Uwc78f25vW1oBgOzHpiXVo5FRhPxvWMi/LPV0W4fvQ93S/9kkjnon9jHk99yi1q01Buf9ZG/madkWSRqdiSnVv1WGgUXd4nx9UtvhaxJHc7j1dUGO2N5LiLvT0wglzYu7t1bcJJJA+CWzyJY1vO3qtxtyqt1KMCSPDH3ZObKuTiK+ZFlNTHjIT+PzkMFfKSvTkhQqIQ1Ut1R2L8nqGHZeY55q+UWNEc++E2WSkEfrd6rUxXptozHqdfgw7MvbAzLLOZEXfZIDXVGI+yOt5YnkJoQN8mFJfODGHx/Nv7qtuTS4JfzxoAXzLTlwux2N0i5DduqBZPyunBmIKO7iLZzsfRtc/BSKcEuDhZ+SWoFcvVz7GXsHM4osNAVvYQ0LkKglvb9jCI+sC/dERhX7goZc5Z12qkK57dlDX/laDOp+WQTtcFfvpUJHZycgFtQBxJn0t5eXG7EJH8fWb3uNngp3yOQQavXKbvzcfzOThLoJcvrm//Y6hbyfugbCJq7rhQ== arkanosis_rssht@Cyclamen
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC0F2vb54ygHajFDxUcLPmQubH/g0ABC1Vr9+dfVIQQdR2NoeN+xGYELCu4F7lCLQqfNZr+7052RC5GDs5g4Rnl4xDd/tBef98WtilJFkZqnoniWD+WcB0zcvDjHwIkNWIWL2ndj90nRkB2OXy7wUHYI8a3YRBSRMawLUHrNktTMLVBMfmSw4gxJmUmL9m1l7QbzgjAKMx/UmczGTlC08yT5GeaLkgFVdQe5AdvKE1yBV2tsJ9saP16Ze2R8HfuM9+2/eDtIz26ahpdAgLJKuNpAupjKXVm9I2/OCgoOL7GKVq3VfloPjEZ2TZphfZao1y8OiEvnOPqLBj16meLuEwiBGGgb1hbqBJZbxYPJ8LPX09axFShVBFEXvlLYZ4hM/07QAxxpl1xcPzbuJy95vkdI+F39F0oApoh1KS3Q4fGXNm5GYOgrGp0+Z5BPKmlikQZzJrl8KbYW5ffCHndUaL1fQ0QgYfujBxlrkD0/XvqB6AStHHlp7o3k3oAlClLHOB29Llq9+Drjb2QGhTsa+leCBZSJ1nrec0yXv9WZobhV6ZM2WDV2bxnCKl66NGayiP2adAxBpkiWsxjKl0se8vI7SXyDUHfSdGycm4ggtmBJ2SYkQc9sYZLu0ynA37efHj+EJgdu1PUa/jhaFGZAxzGM3GeGRxABVanG52k5B0a5w== arkanosis_rssht@Bruyere
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCcw5psAGP01fGrQSbQWnz/SLVJZeBSbgBSAQUff3dPPvbr/LrmW2hjY5NL58NCU1KnjQzm0gFEZWHYZxZKkzLUIQb9q+trQXOYz/ui1TIzvdu+dtcrQF4TjtJVbJfM9ljaOeDXNuScbZgHTJirl1VSf9n3pZsLDl038ici4gHAFvQOdfxKR7rbBxyiXVyIYl3qbBZSUJwhsYl0U6asdYFHTdBsy8v4gd+QUt2Lkoi2VVVxM4nCKKAUtBLvI98zo0NWeWDhWuLY+e1JEWX2g1ak4TUiMmRRaCYnt2bHV3aSKjDNd8fFxO0ERR52xe6N7UIpAwDyI1ITft5cGfL8kVLzi5BMu+P/o4JwMA88S9GqLeA4gwHRiP+iBg+WadfqHT6/ZSLjFP9V0Mm5XlGhEW+HIfF7UEUqudP9V8RY89frSG9pTl2imrJszmIrNolWtUB/pHBUq2lgYW65jzGnbt5kQqy9DeAGTMd2o+YR3Al1nSp3RGLEMcM9VgX/Y4IitrDgn4tnr1TW1KKOyARNaVoICGAlQ1WxZon0XLGNaD0j5x52fbzbL2SarskOsjEX8dFSqb/hlh1ngp8k9TvJu9HgaFgvhIty+wceXfqUdPjj/cYhpT1XEAlvjjWRO+UBvZUImI+5OSzbJkNRG5tqMe7iP57afoAbAMReWFB7KNYVnw== asdp_rssht@Cookie
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJYvAi+0y2mxzNmuCjOZndjWErJjdLexYww5fGF/eu1n0jTopAbUDHxeDiQhLPCUStlrdFVdcpxTqif8vyobxJe/obKOwdJknapm4GUNK6fFulNRR3/xbm6FuGrb809ctdHYcF9vtgW+j086IVnB7jCX8oIqdFCGWoUztzzlgFMQptfO6EpsPRyaGHx23IGxDrWCknTAjzguDCgiD3gcd+qD0S8px9oOb0xKC43AfKY4IVME/pJkbWrfSk3QWA7PWWA0tymh8TqbcgwNzPGUt5feMq4kU49DSFQDeyQSdeXeaPRN4R7S2SurZxZIUMvSwf2oVqWrawfB3aExC32EzLIT/IGJ+157BBnJQ2BPkX0WrcQM+e8YDJflXiwoIB4ZxXyOYUpu+RBaXLNk+hsgkpxH4rhMyhAzJWiro/XNm7B9hTzNVdAanBN/g+vvO2kkof48SIV5YXGkyhj+D4bXy5SM03zhR/F/LfxQInmPOr6p/o0a93uNl8lRRvHk06SJVhzaxPsXfjo3trIH9Q8jFtdVf83YpzuvW9L9cy5IDOMIb9SjhvfCAWOg0qdJwGJNiPmDnUn2imF4iQV2VxIibyaxqVD3XFGkTqvCakHE8Pi2JXMg+31HghR+ecBeghUmmPXa+02W3jLxVyDqrvEpltYvSanXjS+ccuC4FvMxYxvQ== arkanosis_rssht@Brownie

groups:
  - name: famille
    id: 1004
  - name: amis
    id: 1200
