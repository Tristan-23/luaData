-- Function to convert time to minutes
function timeToMinutes(time)
    local hours, minutes = time:match("(%d+):(%d+)")
    hours = tonumber(hours)
    minutes = tonumber(minutes)
    return hours * 60 + minutes
end

-- Function to format duration
function formatDuration(durationMinutes)
    local hours = math.floor(durationMinutes / 60)
    local minutes = durationMinutes % 60
    return string.format("%02d:%02d", hours, minutes)
end

-- Function to prompt user for input
function promptUser(prompt)
    io.write(prompt)
    return io.read()
end

-- Ask for user information
customer = promptUser("Enter customer name: ")
project = promptUser("Enter project name: ")
desc = promptUser("Enter project description: ")
startTime = promptUser("Enter start time (HH:mm): ")
endTime = promptUser("Enter end time (HH:mm): ")
date = promptUser("Enter date (YYYY-MM-DD): ")
user = promptUser("Enter user name (initials): ")

-- Calculate duration
startMinutes = timeToMinutes(startTime)
endMinutes = timeToMinutes(endTime)
durationMinutes = endMinutes - startMinutes

-- Convert duration back to HH:mm format
duration = formatDuration(durationMinutes)

-- Print registration details
print("Registration Details:")
print("Customer:", customer)
print("Project:", project)
print("Description:", desc)
print("Start Time:", startTime)
print("Duration:", duration)
print("End Time:", endTime)
print("Date:", date)
print("User:", user)

-- Ask for confirmation
confirm = promptUser("Is the information correct? (Y/N): ")
if string.upper(confirm) ~= "Y" then
    -- Incorrect data, save to log.txt
    local logFile = io.open("log.txt", "a")
    logFile:write("Incorrect Data\n")
    logFile:write("- Customer: " .. customer .. "\n")
    logFile:write("- Project: " .. project .. "\n")
    logFile:write("- Description: " .. desc .. "\n")
    logFile:write("- Start Time: " .. startTime .. "\n")
    logFile:write("- Duration: " .. duration .. "\n")
    logFile:write("- End Time: " .. endTime .. "\n")
    logFile:write("- Date: " .. date .. "\n")
    logFile:write("- User: " .. user .. "\n\n")
    logFile:close()
    print("Incorrect data saved to log.txt.")
else
    -- Correct data, save to log.txt
    local logFile = io.open("log.txt", "a")
    logFile:write("Correct Data\n")
    logFile:write("- Customer: " .. customer .. "\n")
    logFile:write("- Project: " .. project .. "\n")
    logFile:write("- Description: " .. desc .. "\n")
    logFile:write("- Start Time: " .. startTime .. "\n")
    logFile:write("- Duration: " .. duration .. "\n")
    logFile:write("- End Time: " .. endTime .. "\n")
    logFile:write("- Date: " .. date .. "\n")
    logFile:write("- User: " .. user .. "\n\n")
    logFile:close()
    print("Correct data saved to log.txt.")
end

-- Save to SQL file
saveSQL = promptUser("Do you want to save this information to SQL? (Y/N): ")
if string.upper(saveSQL) == "Y" then
    local insertSQL = string.format("INSERT INTO `tasks` (`customer`, `titel`, `description`, `start`, `duration`, `end`, `date`, `collaborators`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');",
        customer, project, desc, startTime, duration, endTime, date, user)

    local sqlFile = io.open("db.sql", "a")
    sqlFile:write(insertSQL .. "\n\n")
    sqlFile:close()
    print("Information saved to db.sql.")
end