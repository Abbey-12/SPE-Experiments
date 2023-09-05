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
    global lambda;
    lambda=4;
    global mu;
    mu=6;
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

server_status1=0;
server_status2=0;
packet_queue=0;   % number of packet in the queue
n_arrivals=0;     % number of packet arrival
logg=zeros(t_max,4); % log data

% store inter event time , number of packets in the queue and server status
% logg=zeros(t_max,4);

logg(1,1)=0; % each event occurance time
logg(1,2)=0; % number of packets in the queue
logg(1,3)=0; % status of server1
logg(1,4)=0; % status of server 2

N=1;

while 1
   N=N+1;
   e=queue(1,[1,2]);
   queue([1],:)=[];
   
   clock=e.Occurance_time;
   logg(N,1)=clock;

    %number packets in the queue

    switch e.Event_type
    
        case START

             schedule_arrival;

    % insert new arrival
        
    
        case ARRIVAL
    
          if server_status1==1 && server_status2==1
               packet_queue=packet_queue+1;
               logg(N,2)= packet_queue;
          end

        %insert new arrival
               schedule_arrival;
               n_arrivals=n_arrivals+1;
        
           if server_status1==0  && server_status2==1

               % insert next departure
              schedule_departure;
              server_status1=1;
              logg(N,3)=server_status1;
              
          elseif server_status1==1 && server_status2==0
              % insert next departure

              schedule_departure;
              server_status2=1;
              logg(N,4)=server_status2;

          else
             schedule_departure;
             server_status1=1;
             logg(N,3)=server_status1;
             schedule_departure;
             server_status2=1;
             logg(N,4)=server_status2;

          end
    
        case DEPARTURE
             if packet_queue >=2
    
              packet_queue =packet_queue -2;
              logg(N,2)= packet_queue;
              % insert next departure
              schedule_departure;
              server_status1=1;
              logg(N,3)=server_status1;
              schedule_departure;
              server_status2=1;
              logg(N,4)=server_status2;

             elseif packet_queue==1
              packet_queue =packet_queue -1;
              logg(N,2)= packet_queue;

              % insert next departure
              schedule_departure;
              server_choose=rand();
              if server_choose<0.5
              server_status1=1;
              logg(N,3)=server_status1;
              else
               server_status2=1;
               logg(N,4)=server_status2;
              end

            else 
              server_status1=0;
              logg(N,3)=server_status1;
              server_status2=0;
              logg(N,4)=server_status2;
              
             end
    


        case END
               break
    
        case DEBUG  
            fprintf("the current time is :\n " )  
            disp(clock)
            fprintf("server_status1 is : \n" )  
            disp(server_status1)
            fprintf("server_status2 is : \n" )
            disp(server_status2)
            fprintf("packet_queue equals : \n" )  
            disp(packet_queue)
     end
if  clock>=t_max
    break;
end

end

  % retriving stastics
   t_eventocc=logg(:,1);
   pkt_inqueue=logg(:,2);
   pkt_server1=logg(:,3);
   pkt_server2=logg(:,4);
   total_insystem=pkt_server1+pkt_server2+pkt_inqueue;

% Simulated
    wq_sim=(pkt_inqueue)/lambda;
    wq=[wq mean(pkt_inqueue)/lambda];
    simulated_avg = sum(total_insystem)/length(total_insystem);
    averages = [averages simulated_avg];
 end


 % Theoretical average utilization of the system
    c=2;
   
   rhoo = lambda/(c*mu);

    Theoretical_avg = rhoo/(1-rhoo);
    fprintf("Theoretical average utilization of the system is : " );
    disp( Theoretical_avg)
    % Simulated The average utilization
    Average_util=averages(end);
    fprintf("Simulated The average utilization of the system is : " );
    disp(Average_util)

    % Theoretical average waiting time in the queue
    Theoretical_wq =(rhoo^2)/(lambda*(1-rhoo));
    fprintf("Theoretical average waiting time in the queue is :" );
    disp( Theoretical_wq);
    % simulated average waiting in the queue
    wq=wq(end);
    fprintf("Average simulated waiting time in the queue is :" );
    disp(wq) 


 
    % plot packets in system
    plot(t_eventocc,pkt_inqueue,'green');
    hold on
    plot(t_eventocc,pkt_server1,'yellow');
    hold on
    plot(t_eventocc,pkt_server2,'blue');
    hold on
    plot(averages,'red');
    hold on 
    plot( t_eventocc,Theoretical_avg,'black');
    legend('instantanous queue utilization','instantanous server utilization','average system utilaztion')
    title('M/M/1 Lambda=4, mu=6')
    xlabel('Time')
    ylabel('Number of packets in the queue')
    hold off
     figure(2)
    histogram (total_insystem);
    xlim([0 10])
    title('Distribution of the number of packets in the system')
    xlabel('Number of packets')
    ylabel('Number of occurance')
    figure(3)
    histogram (wq_sim);
    xlim([0 5])
    title('Waiting time in the queue')
    xlabel('Waiting time')
    ylabel('Number of occurance')
% histogram plot of number of packets served by each server

 figure(4)
    h1=histogram(pkt_server1);
    xlim([0 1])
    hold on
    h2=histogram(pkt_server2);
    xlim([0 1])
    legend("packets served by server1","packets served by server2")
    xlabel('server status')
    ylabel('occurance ')
    title('Packets served by each server')
    
function schedule_arrival()
    ARRIVAL=1;
    lambda=3;
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
    mu=5;
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



















