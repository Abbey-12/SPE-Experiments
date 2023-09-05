clear all;
close all;
clc 

% Event types Id
START=0;
ARRIVAL=1;
DEPARTURE=2;
DEBUG=3;
END=4;

% Table input parameters
sz=[1,2]; 
vartypes=["double","double"];
varnames=["Occurance_time","Event_type"];

    
wq=[];
averages = [];
for tm =1:10:1000
    global queue;
    queue=table('size',sz,'variableTypes',vartypes,'VariableNames',varnames);
    
    
    %initialization of simulation.
    
    time=0;
    event_type=START;
    
    t_max=tm; % maximum time of simulation
    seed=123;
    rng(seed);
    
    t_end=100;
    end_event=END;
    
    end_sim=table(t_end,end_event); 
    
    t_debug=99.8;
    debug_event=DEBUG;
    
    debug_sim=table(t_debug,debug_event); 
    global lambda
    lambda=6;
    global mu;
    mu=8;
    global start_sim;
    start_sim=table(time,event_type);
    
    global arrival;
    arrival=table(time,event_type);
    
    global Departure;
    Departure=table(time,event_type);
    
    global clock; 
    clock=0;    % set clock
    
    queue(end,:)=start_sim;   % insert start event
    queue(end+1,:)=debug_sim;
    queue(end+1,:)=end_sim;   % insert end event
    
    
    
    %%%Event manager
    
    server_status=0;
    packet_queue=0;  % number of packet in the queue
    n_arrivals=0;    % number of packet arrival
  
    
 % store occurance time,number of packets in the queue and server status
    logg=zeros(t_max,3);
    
    logg(1,1)=0;
    logg(1,2)=0;
    logg(1,3)=0;
    
    N=1;
    
    while 1
       N=N+1;
       e=queue(1,[1,2]);
       queue([1],:)=[];
       
       clock=e.Occurance_time;
       logg(N,1)=clock; % logging each event occurance time
  
        switch e.Event_type
        
            case START

                schedule_arrival;
    
        % insert new arrival
            case ARRIVAL
        
               if server_status==1
                   packet_queue=packet_queue+1;
                   logg(N,2)= packet_queue;
               end
    
            %insert new arrival
                   schedule_arrival;
                   n_arrivals=n_arrivals+1;
               if server_status==0 
                
                      % insert next departure
                      schedule_departure;
                      server_status=1;
                     
                     logg(N,3)=server_status;
               end
        
            case DEPARTURE
                 if packet_queue >0
        
                      packet_queue =packet_queue -1;
                      logg(N,2)= packet_queue;
                      % insert next departure
                      schedule_departure;
                      server_status=1;
                      logg(N,3)=server_status;
                 else 
                      server_status=0;
                      
                      logg(N,3)=server_status;
                 end
        
            case END
                   break;
        
            case DEBUG  
                fprintf("the current time is :\n " )  
                disp(clock)
                fprintf("server_status is : \n" )  
                disp(server_status)
                fprintf("packet_queue equals : \n" )  
                disp(server_status)
         end
    if  clock>=t_max
        break;
    end
    
    end



    % retriving stastics
    t_eventocc=logg(:,1);
    inqueue_pkt=logg(:,2);
    wq_sim= inqueue_pkt/lambda;
    wq=[wq mean(inqueue_pkt)/lambda];
  
    inservice_pkt=logg(:,3);
    insystem_total=inqueue_pkt+inservice_pkt;

  
   % simulated value
    simulated_avg = sum(insystem_total)/length(insystem_total);
    averages = [averages simulated_avg];
    

end
     Average_util=averages(end);
     
    % Theoretical total number pakcets in the system
       
        rhoo = lambda/mu;
 
    Theoretical_avg = rhoo/(1-rhoo);
    fprintf("Average theoretical utilization of the system is : " );
    disp( Theoretical_avg)
    % simulated average utilization
    fprintf("Average simulted utilization of the system is :" );
    disp(Average_util)

    % Theoretical average waiting time in the queue
    Theoretical_wq =(rhoo^2)/(lambda*(1-rhoo));
    fprintf("Theoretical average waiting time in the queue is :" );
    disp( Theoretical_wq);
    % simulated average wait
    wq=wq(end);
    fprintf("Average simulated waiting time in the queue is :" );
    disp(wq) 
    

% plot packets in system
    plot(t_eventocc,inqueue_pkt,'green');
    hold on
    plot(t_eventocc,inservice_pkt,'blue');
    hold on
    plot(averages,'red');
    hold on 
    plot(t_eventocc,Theoretical_wq,'black');
    legend('instantanous queue utilization','instantanous server utilization','average system utilaztion','theortical average')
    title('M/M/1 Lambda=6, mu=8')
    xlabel('Time')
    ylabel('Number of packets in the system')
    hold off
    figure(2)
    histogram (insystem_total);
    xlim([0 10])
    title('Distribution of the number of packets in the system')
    xlabel('Number of packets')
    ylabel('Number of occurance')
    figure(3)
    histogram (wq_sim);
    xlim([0 10])
    title('Waiting time in the queue')
    xlabel('Waiting time')
    ylabel('Number of occurance')



function schedule_arrival()
    ARRIVAL=1;
    global lambda;
    global clock; 
    t=clock-(log(rand())/lambda);
    clock =t;
    global arrival;
    e=arrival;
    e.time=t;
    e.event_type=ARRIVAL;
    insQueue(e);
end


% departure scheduling
function schedule_departure()
    DEPARTURE=2;
    global mu;
    global clock;
    t=clock-(log(rand())/mu);
    clock =t;
    global Departure;
    e= Departure;
    e.time=t;
    e.event_type=DEPARTURE;
    insQueue(e);

end

% insert in queue function
function insQueue(e)
    global queue;
    queue(end+1,:)=e;
    queue = sortrows(queue,1);
end



















