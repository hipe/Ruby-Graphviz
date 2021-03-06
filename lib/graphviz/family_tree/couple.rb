class GraphViz
  class FamilyTree
    class Couple
      def initialize( g, n ) #:nodoc:
        @graph = g
        @node = n
      end
      
      def node #:nodoc:
        @node
      end
      
      # Add kids to a couple
      def kids( *z )
        if z.size == 1
          @graph.add_edge( @node, z[0].node, "dir" => "none" )
        else
          cluster = @graph.add_graph( "#{@node.name}Kids" )
          cluster["rank"] = "same"

          last = nil
          count = 0
          add = (z.size-1)%2 * z.size/2 + (z.size-1)%2
          link = (z.size/2)+1 

          z.each do |person|
            count = count + 1
            if count == add
              middle = cluster.add_node( "#{@node.name}Kids", "shape" => "point" )
              @graph.add_edge( @node, middle, "dir" => "none" )
              unless last.nil?
                cluster.add_edge( last, middle, "dir" => "none" )
              end              
              last = middle
            end
            
            kid = cluster.add_node( "#{person.node.name}Kid", "shape" => "point" )
            @graph.add_edge( kid, person.node, "dir" => "none" )
            
            if add == 0 and count == link
              @graph.add_edge( @node, kid, "dir" => "none" )
            end
            
            unless last.nil?
              cluster.add_edge( last, kid, "dir" => "none" )
            end
            last = kid
          end
        end        
      end
    end
  end
end
