keySet = {'Jan','Feb','Mar','Apr'};
valueSet = {[487],[368.2],[197.6,16],[178.4,17]};
M = containers.Map(keySet,valueSet)
disp(M('Jan'))