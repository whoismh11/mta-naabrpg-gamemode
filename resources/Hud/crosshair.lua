local hudTextureNames = {
	"cameraCrosshair",
	"font1",
	"font2",
	"siteM16",
	"siterocket",
	"SNIPERcrosshair",
}

function replaceTexture(textureName, imgPath)
	local textureReplaceShader = dxCreateShader("texture_replace.fx", 0, 0, false, "world")
    local texture = dxCreateTexture(imgPath .. textureName .. ".png")
    dxSetShaderValue(textureReplaceShader, "gTexture", texture)
    engineApplyShaderToWorldTexture(textureReplaceShader, textureName)
end

function replaceTextures()
    for i, textureName in ipairs(hudTextureNames) do
    	replaceTexture(textureName, "images/")
    end
end

addEventHandler("onClientResourceStart", resourceRoot, replaceTextures)
