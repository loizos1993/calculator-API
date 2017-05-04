{-# LANGUAGE QuasiQuotes           #-}
import Yesod
import Data.Maybe (fromMaybe)
import Data.Text (pack)
import Data.List.Split (splitOn)
import System.IO.Unsafe

data Calculator = Calculator

-- Routes
mkYesod "Calculator" [parseRoutes|
/ HomeRoute GET                         -- get user
/login/#String/#String LoginRoute GET   -- login
/logout LogoutRoute GET                 -- logout
/history HistoryRoute GET               -- history
/add/#Integer/#Integer AddRoute         -- add
/sub/#Integer/#Integer SubRoute         -- sub
/mul/#Integer/#Integer MulRoute         -- mul
/div/#Integer/#Integer DivRoute         -- div
|]

-- Get username if logged
getHomeRoute = do
    session <- lookupSession "user"
    let result = fromMaybe "None" session
    return $ object ["result" .= result]

-- Store history
addToHistoryAndSave "None" _ = do
    return ()
addToHistoryAndSave user op = do
    let body  = map (splitOn ",") $ lines2 (loadFile "history.txt")
    let history = addToHistory user op body
    liftIO $ putStrLn $ show $ length history
    liftIO $ writeFile "history.txt" $ showHistory 
        $ map (filter (\ x -> x /= "\n" && x /= "")) history
    return ()

-- Convert user session to string
showSession :: String -> String
showSession "Nothing" = "None"
showSession s = 
    takeWhile (\ c -> c /= '\"') $ tail $ dropWhile (\ c -> c /= '\"') s

-- Get user history (helper)
getHistory "None" = do
    return $ object ["result" .= "null"]
getHistory user = do
    let body = map (splitOn ",") $ lines2 (loadFile "history.txt")
    let hist = getUserHistory body user
    let history = 
            if (hist == [])
            then []
            else filter (\ x -> x /= "\n" && x /= "") $ tail $ head hist
    return $ object ["result" .= history]
   
-- Get user history
getHistoryRoute = do
    session <- lookupSession "user"
    let username = showSession $ show session
    getHistory username
  
-- Logout user
getLogoutRoute = do
    deleteSession "user"
    return $ object ["result" .= "OK"]

-- Login user
getLoginRoute login pass = do
    checkLogin (checkUser login pass) login

-- Login helper
checkLogin True login = do
    setSession "user" (pack login)
    return $ object ["result" .= "OK"]
checkLogin False _ = do
    return $ object ["result" .= "Forbidden"]
  
-- Handle addition
handleAddRoute a b = do
    session <- lookupSession "user"
    let username = showSession $ show session
    addToHistoryAndSave username $ "add " ++ show(a) ++ " " ++ show(b)
    return $ object ["result" .= (a + b)]

-- Handle subtraction
handleSubRoute a b = do
    session <- lookupSession "user"
    let username = showSession $ show session
    addToHistoryAndSave username $ "sub " ++ show(a) ++ " " ++ show(b)
    return $ object ["result" .= (a - b)]

-- Handle multiplication
handleMulRoute a b = do
    session <- lookupSession "user"
    let username = showSession $ show session
    addToHistoryAndSave username $ "mul " ++ show(a) ++ " " ++ show(b)
    return $ object ["result" .= (a * b)]

-- Handle division
handleDivRoute a b = do
    session <- lookupSession "user"
    let username = showSession $ show session
    addToHistoryAndSave username $ "div " ++ show(a) ++ " " ++ show(b)
    return $ object ["result" .= (div a b)]

-- Convert history to a string
showHistory :: [[String]] -> String
showHistory history = 
    foldr (\x y -> x ++ "\r\n" ++ y) "" 
        $ map (\ line -> foldr (\ x y -> x ++ "," ++ y) "" line) history

-- Get a user's history
getUserHistory :: [[String]] -> String -> [[String]]
getUserHistory history user = filter (\ (username:_) -> username == user) history

-- Add a new request to history of user
addToHistory :: String -> String -> [[String]] -> [[String]]
addToHistory user op history = 
    if userExists
    then (user:op:userHistory):removeUserFromHistory
    else [user,op]:history
    where
    userExists = (length finduser) > 0
    userHistory = tail $ head $ finduser
    finduser = filter (\ (username:_) -> username == user) history
    removeUserFromHistory = filter (\ (username:_) -> username /= user) history

-- Load history and return as list
loadHistory :: [[String]]
loadHistory = map (splitOn ",") $ lines2 $ loadFile "history.txt"

-- Load a file
loadFile :: String -> String
loadFile f = unsafePerformIO . readFile $ f
   
-- Check if the user and password are valid
checkUser :: String -> String -> Bool
checkUser user password = 
    elem [user, password] $ map (splitOn " ") $ lines2 $ loadFile "users.txt"

-- Split a string into lines
lines2 :: String -> [String]
lines2 = splitOn "\r\n"

instance Yesod Calculator where
    makeSessionBackend _ = do
        backend <- defaultClientSessionBackend 1 "keyfile.aes"
        return $ Just backend

-- Start the web server
main :: IO ()
main = warp 3000 Calculator
