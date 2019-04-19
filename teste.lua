function testeando()
    local teste = 10
    io.write(teste,'\n')
    _G.haha = teste
end

testeando()

io.write(haha)